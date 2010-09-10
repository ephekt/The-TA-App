class RemoveRoleFromuser < ActiveRecord::Migration
  def self.up
    remove_column :users, :u_role    
  end

  def self.down
  end
end
