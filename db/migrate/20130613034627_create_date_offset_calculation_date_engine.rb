class CreateDateOffsetCalculationDateEngine < ActiveRecord::Migration
  def change
    create_table :date_offset_calculation_dates do |table|
      table.timestamps

      table.string :event_type, null: false
      table.string :modifier, null: false
      table.integer :day_count, null: false
    end
  end
end
