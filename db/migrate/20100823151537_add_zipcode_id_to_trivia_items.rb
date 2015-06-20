class AddZipcodeIdToTriviaItems < ActiveRecord::Migration
  def self.up
    add_column :zipcodes, :zipcode_id, :integer
    add_index :zipcodes, :zipcode_id
  end

  def self.down
    remove_column :zipcodes, :zipcode_id
  end
end
