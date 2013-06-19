class AddCommissionsTable < ActiveRecord::Migration
  def change
    create_table :commissions do |table|
      table.timestamps

      table.datetime :payment_date, null: false
      table.decimal :amount, null: false
      table.references :user, null: false
    end
  end
end
