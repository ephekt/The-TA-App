class Review < ActiveRecord::Base
  include AASM

  aasm_initial_state :created
  aasm_state :created
  aasm_state :pending
  aasm_state :completed
  

  #aasm_event :mark_as_completed do
  #  transitions :to => :completed, :from => [:pending], :guard => :has_required_fields?
  #end

  before_create :generate_token
  belongs_to :course, :foreign_key => 'course_id'
  belongs_to( :student, :foreign_key => 'student_id', :class_name => 'Student' )
  belongs_to( :reviewer, :foreign_key => 'reviewer_id', :class_name => 'Student' )
  named_scope :completed, {:conditions => "aasm_state = 'completed'"}
  named_scope :by_state_and_course, lambda { |state, course_id|
      { :conditions =>  [ "aasm_state = ? AND course_id = ?", state, course_id ] }
  }

  named_scope :for_student, lambda { |student_id|
        { :conditions => { :student_id=> student_id } }
      }
  named_scope :by_student, lambda { |reviewer_id|
        { :conditions => { :reviewer_id => reviewer_id } }
      }
  named_scope :for_quarter, lambda { |course_id| 
     { :conditions => { :course_id => course_id}}}
     
  private
  def has_required_fields?
    true unless (self.grade.nil?)
  end
  
  def has_or_send_token_email
  end
  
  def generate_token
    self.token = Authlogic::Random.friendly_token
  end
end
