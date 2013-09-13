class CreateGotFixedIssues < ActiveRecord::Migration
  def change
    create_table :got_fixed_issues do |t|
      t.string :title
      t.boolean :closed

      t.timestamps
    end
  end
end
