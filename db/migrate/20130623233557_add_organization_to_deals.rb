class AddOrganizationToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :organization_id, :integer
  end
end
