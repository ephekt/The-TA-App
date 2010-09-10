class Student < ActiveRecord::Base
  has_many :reviews
  belongs_to :group
  has_many :notes
  
  validates_presence_of :name
  validates_presence_of :email
  named_scope :currently_active, lambda { {:conditions => {:active => true}}}
  
  def need_to_review
    need_to_review = []
    pending_reviews = []
    course_id = Course.last.id
    group.students.each do |other_student|
      next if other_student.name == name || !other_student.active
      found = false
      other_student.reviews.each do |other_students_review|
        if other_students_review.reviewer_id == id && other_students_review.course_id == course_id# they have been reviewed by me
            found = true 
          if other_students_review.aasm_state == 'created' || other_students_review.aasm_state == 'pending'
            pending_reviews << other_students_review
          end
        end
      end
      need_to_review << other_student if !found
    end
    { :uncreated => need_to_review, :created => pending_reviews}
  end
  
  
  def need_reviews_from
    need_reviews_from = []
    pending_reviews = []
    course_id = Course.last.id
    group.students.each do |other_student|
      next if other_student.name == name || !other_student.active
      found = false
      reviews.each do |my_review|
        if my_review.reviewer_id == other_student.id && my_review.course_id == course_id# they have reviewed by me
          found = true          
          if my_review.aasm_state == "created" || my_review.aasm_state == "pending"
            pending_reviews << my_review
          end
        end
      end
      need_reviews_from << other_student unless found
    end
    { :uncreated => need_reviews_from, :created => pending_reviews}
  end
  
  def has_reviewed_this_quarter? q
    reviews.each do |r|
      return true if r.course_id = q && r.reviewer_id = self.id
    end
    return false
  end
  def has_been_reviewed_this_quarter? q
    reviews.each do |r|
      return true if r.course_id = q && r.reviewee_id = self.id
    end
    return false
  end
end
