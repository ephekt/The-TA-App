class AddCurrentCourseToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :course_id, :integer
  end

  def self.down
  end
end
