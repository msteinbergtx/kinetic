class Organization < ActiveRecord::Base
  has_many :users
  has_many :rules
  has_many :deals

  validates :name, presence: true
end
