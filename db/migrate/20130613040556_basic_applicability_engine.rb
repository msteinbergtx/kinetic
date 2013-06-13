class BasicApplicabilityEngine < ActiveRecord::Migration
  def change
    create_table :basic_applicabilities do |table|
      table.timestamps

      table.string :calculation, null: false
    end
  end
end
