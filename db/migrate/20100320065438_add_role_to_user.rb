class AddRoleToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :u_role, :string, :default => 'student'
  end

  def self.down
  end
end
