class UniqueUserEmails < ActiveRecord::Migration
  def change
    add_index :got_fixed_users, :email, unique: true
  end
end
