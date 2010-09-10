class AddStateToReviews < ActiveRecord::Migration
  def self.up
    add_column :reviews, :aasm_state, :string, :default => 'created'
  end

  def self.down
  end
end
