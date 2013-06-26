class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :commissions
  belongs_to :organization

  attr_accessible :email, :password, :password_confirmation, :remember_me

  before_create :set_base_role

  def is?(role)
    roles.include?(role.to_s)
  end

  def add_role(role)
    self.roles = self.roles + [role.to_s]
  end

  def remove_role(role)
    new_roles = self.roles - [role.to_s]
    if new_roles.length == 0
      raise 'user must have at least one role'
    else
      self.roles = new_roles
    end
  end

  private

  def set_base_role
    self.roles ||= ['user']
  end
end
