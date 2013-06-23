class RemoveBasicPaymentAmountsCreateBasicCompensation < ActiveRecord::Migration
  def up
    create_table :basic_compensations do |table|
      table.timestamps

      table.string :calculation, null: false
    end
    drop_table :basic_payment_amounts
  end

  def down
    create_table :basic_payment_amounts do |table|
      table.timestamps

      table.string :calculation, null: false
    end
    drop_table :basic_compensations
  end
end
