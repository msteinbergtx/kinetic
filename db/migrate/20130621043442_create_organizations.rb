class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |table|
      table.timestamps

      table.string :name, null: false
    end

    add_column :users, :organization_id, :integer
  end
end
