class Engine::BasicApplicability < ActiveRecord::Base
  has_one :rule, as: :applicability_engine

  validates :calculation, presence: true

  attr_accessible :calculation

  def filter_rules(deals)
    deals.where(calculation)
  end
end
