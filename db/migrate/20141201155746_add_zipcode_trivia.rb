class AddZipcodeTrivia < ActiveRecord::Migration
  def self.up
    add_column :trivia_items, :zip_code, :string
  end

  def self.down
    remove_column :trivia_items, :zip_code
  end
end
