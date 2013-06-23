class AddPaymentDateToCommissionSchedules < ActiveRecord::Migration
  def change
    add_column :commission_schedules, :commission_payment_date, :datetime
  end
end
