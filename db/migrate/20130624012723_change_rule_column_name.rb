class ChangeRuleColumnName < ActiveRecord::Migration
  def change
    rename_column :rules, :payment_amount_engine_id, :compensation_engine_id
    rename_column :rules, :payment_amount_engine_type, :compensation_engine_type
  end
end
