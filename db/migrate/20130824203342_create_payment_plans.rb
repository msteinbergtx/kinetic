class CreatePaymentPlans < ActiveRecord::Migration
  def change
    create_table :payment_plans do |t|
      t.timestamps

      t.references :user, null: false
    end
  end
end
