class CommissionsController < ApplicationController
  def index
    @commissions = current_user.commissions
  end
end
