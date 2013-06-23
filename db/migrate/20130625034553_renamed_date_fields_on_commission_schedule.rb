class RenamedDateFieldsOnCommissionSchedule < ActiveRecord::Migration
  def change
   rename_column :commission_schedules,
     :commissions_calculated_date,
     :commission_calculated_date
   rename_column :commission_schedules,
     :calculate_commissions_date,
     :calculate_commission_date
  end
end
