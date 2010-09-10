class RemoveStudentReviewerColumnFromStudents < ActiveRecord::Migration
  def self.up
    remove_column :reviews, :student
    remove_column :reviews, :reviewer    
  end

  def self.down
  end
end
