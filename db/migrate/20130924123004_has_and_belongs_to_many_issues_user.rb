class HasAndBelongsToManyIssuesUser < ActiveRecord::Migration
  def change
    create_table :got_fixed_issues_users do |t|
      t.belongs_to :user
      t.belongs_to :issue
    end
  end
end
