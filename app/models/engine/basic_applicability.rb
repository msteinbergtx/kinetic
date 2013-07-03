class Engine::BasicApplicability < ActiveRecord::Base
  has_one :rule, as: :applicability_engine

  validates :calculation, presence: true

  attr_accessible :calculation

  def filter_rules(deals)
    column_information = calculation.scan(/\w+?:\[.+?\]/)
    values_for_query = column_information.
      map { |value| value.gsub(/\w+:\[(?<value>.+)\]/, "\\k<value>") }
    query_for_where = calculation.gsub(/\w+?:\[.+?\]/, '?')
    deals.where(query_for_where, *values_for_query)
  end
end
