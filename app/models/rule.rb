class Rule < ActiveRecord::Base
  belongs_to :applicability_engine, polymorphic: true
  belongs_to :calculation_date_engine, polymorphic: true
  belongs_to :payment_amount_engine, polymorphic: true
  belongs_to :payment_date_engine, polymorphic: true
  belongs_to :organization

  validates :name, presence: true
  validates :active, inclusion: { in: [true, false] }

  accepts_nested_attributes_for :applicability_engine,
    :calculation_date_engine,
    :payment_amount_engine,
    :payment_date_engine
end
