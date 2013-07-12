class HomeController < ApplicationController
  def index
    if current_user.is?(:admin) || current_user.is?(:moderator)
      @rules = current_organization.rules.includes(:deals)
      render(template: 'home/admin_home')
    elsif current_user.is?(:user)
      @commissions = current_user.commissions
      render(template: 'home/user_home')
    end
  end
end
