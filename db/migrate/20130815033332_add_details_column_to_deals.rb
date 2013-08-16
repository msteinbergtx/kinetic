class AddDetailsColumnToDeals < ActiveRecord::Migration
  def self.up
    execute "CREATE EXTENSION hstore"
    add_column :deals, :details, :hstore
  end

  def self.down
    remove_column :deals, :details
    execute "DROP EXTENSION hstore"
  end
end
