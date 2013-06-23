class CreateDealsRulesTable < ActiveRecord::Migration
  def change
    create_table :commission_schedules do |table|
      table.timestamps

      table.references :deal, null: false
      table.references :rule, null: false
      table.datetime :commissions_calculated_date
      table.datetime :calculate_commissions_date
    end
  end
end
