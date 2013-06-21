class AddOrganizationToRules < ActiveRecord::Migration
  def change
    add_column :rules, :organization_id, :integer, null: false
  end
end
