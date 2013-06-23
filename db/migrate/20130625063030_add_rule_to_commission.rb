class AddRuleToCommission < ActiveRecord::Migration
  def change
    add_column :commissions, :rule_id, :integer
  end
end
