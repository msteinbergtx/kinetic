class Organization < ActiveRecord::Base
  has_many :users
  has_many :rules

  validates :name, presence: true
end
