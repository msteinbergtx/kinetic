class CreateDeal < ActiveRecord::Migration
  def change
    create_table :deals do |table|
      table.timestamps

      table.string :name, null: false
      table.decimal :amount, null: false
      table.datetime :sell_date, null: false
      table.datetime :start_date, null: false
      table.datetime :end_date
    end
  end
end
