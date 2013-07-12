class HomeController < ApplicationController
  def index
    if current_user.is?(:moderator)

    elsif current_user.is?(:admin)

    elsif current_user.is?(:user)
      @commissions = current_user.commissions
      render(template: 'home/user_home')
    end
  end
end
