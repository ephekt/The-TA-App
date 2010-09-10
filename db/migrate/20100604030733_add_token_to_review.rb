class AddTokenToReview < ActiveRecord::Migration
  def self.up
    add_column :reviews, :token, :string, :default => Authlogic::Random.friendly_token
  end

  def self.down
  end
end
