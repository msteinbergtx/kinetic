class MigrateDealColumnsToHstore < ActiveRecord::Migration
  class Deal < ActiveRecord::Base
  end

  def up
    Deal.all.each do |deal|
      deal.details = {
        'sell_date' => deal.sell_date,
        'start_date' => deal.start_date,
        'end_date' => deal.end_date,
        'amount' => deal.amount
      }
      deal.save!
    end
    remove_column :deals, :sell_date
    remove_column :deals, :start_date
    remove_column :deals, :end_date
    remove_column :deals, :amount
  end

  def down
    add_column :deals, :sell_date, :datetime
    add_column :deals, :start_date, :datetime
    add_column :deals, :end_date, :datetime
    add_column :deals, :amount, :decimal
    Deal.reset_column_information

    Deal.all.each do |deal|
      deal.sell_date = deal.details['sell_date']
      deal.start_date = deal.details['start_date']
      deal.end_date = deal.details['end_date']
      deal.amount = deal.details['amount']
      deal.save!
    end
  end
end
