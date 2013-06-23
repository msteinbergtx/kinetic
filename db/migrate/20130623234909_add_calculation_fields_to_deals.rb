class AddCalculationFieldsToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :rules_associated_date, :datetime
  end
end
