class AddCourseToResources < ActiveRecord::Migration
  def self.up
    add_column :reviews, :course_id, :integer
  end

  def self.down
  end
end
