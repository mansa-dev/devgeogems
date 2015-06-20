class AddLatLngToTriviaItems < ActiveRecord::Migration
  def self.up
    add_column :trivia_items, :latitude, :float
    add_column :trivia_items, :longitude, :float
    add_index :trivia_items, [:latitude, :longitude]
  end

  def self.down
    remove_column :trivia_items, :latitude
    remove_column :trivia_items, :longitude
  end
end
