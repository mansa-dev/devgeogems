class AddDeviseToAdminUsers < ActiveRecord::Migration
  def self.up
    change_table(:admin_users) do |t|

    end

    # add_index :admin_users, :email,                :unique => true
    # add_index :admin_users, :reset_password_token, :unique => true
  end

  def self.down
    # By default, we don't want to make any assumption about how to roll back a migration when your
    # model already existed. Please edit below which fields you would like to remove in this migration.
    raise ActiveRecord::IrreversibleMigration
  end
end
