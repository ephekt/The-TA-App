class AddActiveToStudent < ActiveRecord::Migration
  def self.up
    add_column :students, :active, :boolean, :default => true
  end

  def self.down
  end
end
