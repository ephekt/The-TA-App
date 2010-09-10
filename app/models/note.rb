class Note < ActiveRecord::Base
  belongs_to :group, :foreign_key => 'group_id'
  belongs_to :student, :foreign_key => 'student_id'
  
  validates_presence_of :text
end
