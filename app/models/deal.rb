class Deal < ActiveRecord::Base
  validates :name, :amount, :sell_date, :start_date, presence: true
end
