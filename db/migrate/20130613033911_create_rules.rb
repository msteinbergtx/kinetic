class CreateRules < ActiveRecord::Migration
  def change
    create_table :rules do |table|
      table.timestamps

      table.string :name, null: false
      table.boolean :active, null: false
      table.datetime :start_date
      table.datetime :end_date
      table.references :calculation_date_engine, polymorphic: true, null: false
      table.references :payment_date_engine, polymorphic: true, null: false
      table.references :payment_amount_engine, polymorphic: true, null: false
      table.references :applicability_engine, polymorphic: true, null: false
    end
  end
end
