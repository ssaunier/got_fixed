class CreateGotFixedUsers < ActiveRecord::Migration
  def change
    create_table :got_fixed_users do |t|
      t.string :email

      t.timestamps
    end
  end
end
