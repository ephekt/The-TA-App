class AddStudentToReview < ActiveRecord::Migration
  def self.up
    add_column :reviews, :student_id, :integer
    add_column :reviews, :reviewer_id, :integer
  end

  def self.down    
  end
end
