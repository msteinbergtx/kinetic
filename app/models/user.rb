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

  def roles
    @roles ||= get_unmemoized_roles_array.freeze
  end

  def add_role(role)
    split_roles = get_unmemoized_roles_array
    split_roles << role
    reset_roles(split_roles)
  end

  def remove_role(role)
    split_roles = get_unmemoized_roles_array
    split_roles.delete(role.to_s)
    reset_roles_after_removal(split_roles)
  end

  private

  def get_unmemoized_roles_array
    if roles_list.present?
      roles_list.split('|')
    else
      []
    end
  end

  def reset_roles_after_removal(split_roles)
    if(split_roles.length == 0)
      raise 'user must have at least one role'
    else
      reset_roles(split_roles)
    end
  end

  def reset_roles(split_roles)
    self.roles_list = split_roles.join('|')
    @roles = nil
  end

  def set_base_role
    self.add_role(:user)
  end
end
