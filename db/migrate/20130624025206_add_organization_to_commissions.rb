class AddOrganizationToCommissions < ActiveRecord::Migration
  def change
    add_column :commissions, :organization_id, :integer
  end
end
