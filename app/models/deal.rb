class Deal < ActiveRecord::Base
  belongs_to :user
  belongs_to :organization

  has_many :commissions

  has_many :commission_schedules
  has_many :rules, through: :commission_schedules

  validates :user,
    :organization,
    :name,
    :details,
    presence: true

  def get_decimal(key)
    get_detail(key) do |key_string|
      details[key_string].to_d
    end
  end

  def get_datetime(key)
    get_detail(key) do |key_string|
      DateTime.parse(details[key_string])
    end
  end

  def self.not_associated
    where('rules_associated_date IS NULL')
  end

  private

  def get_detail(key)
    key_string = key.to_s
    if details.key?(key_string)
      yield(key_string)
    end
  end
end
