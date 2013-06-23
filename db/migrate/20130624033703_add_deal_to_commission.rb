class AddDealToCommission < ActiveRecord::Migration
  def change
    add_column :commissions, :deal_id, :integer
  end
end
