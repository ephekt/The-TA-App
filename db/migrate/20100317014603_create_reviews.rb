class CreateReviews < ActiveRecord::Migration
  def self.up
    create_table :reviews do |t|
      t.string :reviewer
      t.string :student      
      t.text :review
      t.decimal :grade

      t.timestamps
    end
  end

  def self.down
    drop_table :reviews
  end
end
