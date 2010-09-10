class AddSavedByTokenToReview < ActiveRecord::Migration
  def self.up
    add_column :reviews, :saved_by_token, :boolean, :default => false
  end

  def self.down
  end
end
