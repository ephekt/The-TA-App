class ChangeUserGroup < ActiveRecord::Migration
  def self.up
    remove_column :students, :group
    add_column :students, :group_id, :integer
  end

  def self.down
  end
end
