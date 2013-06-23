class Deal < ActiveRecord::Base
  belongs_to :user
  belongs_to :organization

  has_many :commissions

  has_many :commission_schedules
  has_many :rules, through: :commission_schedules

  validates :user,
    :organization,
    :name,
    :amount,
    :sell_date,
    :start_date,
    presence: true

  def self.not_associated
    where('rules_associated_date IS NULL')
  end
end
