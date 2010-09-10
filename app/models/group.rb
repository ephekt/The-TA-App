class Group < ActiveRecord::Base
  has_many :students
  has_many :notes
  
  def active_students
    active_students = []
    students.each do |s|
      puts s.name
      active_students << s if s.active?
    end
    active_students
  end
  
  def inactive_students
    inactive_students = []
    students.each do |s|
      puts s.name
      inactive_students << s if !s.active?
    end
    inactive_students
  end  
end
