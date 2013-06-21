class AddRolesToUsers < ActiveRecord::Migration
  def up
    add_column :users, :roles_list, :string
    remove_column :users, :admin
  end

  def down
    remove_column :users, :roles_list
    add_column :users, :admin, :boolean
  end
end
