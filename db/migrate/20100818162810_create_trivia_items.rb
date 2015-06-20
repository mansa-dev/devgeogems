class CreateTriviaItems < ActiveRecord::Migration
  def self.up
    create_table :trivia_items do |t|
      t.string :state
      t.string :city
      t.string :country, :default => "USA"
      t.references :source
      t.references :category
      t.references :contributor
      t.string :content
      t.string :zip_code
      t.timestamps
    end
  end

  def self.down
    drop_table :trivia_items
  end
end
