class AddActiveBooleanToGroup < ActiveRecord::Migration
  def self.up
    add_column :groups, :active, :boolean, :default => true
  end

  def self.down
  end
end
