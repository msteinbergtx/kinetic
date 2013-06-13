class CreateDateOffsetPaymentDateEngine < ActiveRecord::Migration
  def change
    create_table :date_offset_payment_dates do |table|
      table.timestamps

      table.string :event_type, null: false
      table.string :modifier, null: false
      table.integer :day_count, null: false
    end
  end
end
