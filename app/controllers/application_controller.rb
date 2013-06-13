class ApplicationController < ActionController::Base
  include ActiveModel::ForbiddenAttributesProtection

  protect_from_forgery
  before_filter :authenticate_user!
end
