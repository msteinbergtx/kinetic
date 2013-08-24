class Commission < ActiveRecord::Base
  has_many :payments

  belongs_to :user
  belongs_to :organization
  belongs_to :deal
  belongs_to :rule

  validates :user, :organization, :payment_date, :amount, presence: true

  attr_accessible :user, :organization, :payment_date, :amount, :deal, :rule
end
