class ChangeUsersRolesToAnArray < ActiveRecord::Migration
  class User < ActiveRecord::Base
  end

  def up
    add_column :users, :roles, :string, array: true
    User.reset_column_information
    User.all.each do |user|
      user.roles = user.roles_list.split('|')
      user.save!
    end
    remove_column :users, :roles_list
  end

  def down
    add_column :users, :roles_list, :string
    User.reset_column_information
    User.all.each do |user|
      user.roles_list = user.roles.join('|')
      user.save!
    end
    remove_column :users, :roles
  end
end
