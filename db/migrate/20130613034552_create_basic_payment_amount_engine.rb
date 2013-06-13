class CreateBasicPaymentAmountEngine < ActiveRecord::Migration
  def change
    create_table :basic_payment_amounts do |table|
      table.timestamps

      table.string :calculation, null: false
    end
  end
end
