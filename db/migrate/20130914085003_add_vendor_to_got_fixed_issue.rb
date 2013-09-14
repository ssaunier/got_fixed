class AddVendorToGotFixedIssue < ActiveRecord::Migration
  def change
    add_column :got_fixed_issues, :vendor, :string
  end
end
