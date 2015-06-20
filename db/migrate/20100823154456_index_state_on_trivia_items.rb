class IndexStateOnTriviaItems < ActiveRecord::Migration
  def self.up
    add_index :trivia_items, :state
  end

  def self.down
    remove_index :trivia_items, :state
  end
end
