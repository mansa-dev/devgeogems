class RemoveZipCodeFromTriviaItems < ActiveRecord::Migration
  def self.up
    remove_column :trivia_items, :zip_code
  end

  def self.down
    add_column :trivia_items, :zip_code, :string
  end
end
