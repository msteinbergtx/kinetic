class HomeController < ApplicationController
  before_filter :authenticate_user!

  def index
    @commissions = current_user.commissions
  end
end
