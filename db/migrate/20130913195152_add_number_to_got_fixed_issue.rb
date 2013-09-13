class AddNumberToGotFixedIssue < ActiveRecord::Migration
  def change
    add_column :got_fixed_issues, :number, :integer
    add_column :got_fixed_issues, :vendor_id, :string
  end
end
