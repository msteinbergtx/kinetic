class CreatePaymentsTable < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.timestamps

      t.decimal :amount, null: false
      t.datetime :payment_date, null: false
      t.references :user, null: false
      t.references :commission, null: false
    end
  end
end
