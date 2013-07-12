class ApplicationController < ActionController::Base
  include ActiveModel::ForbiddenAttributesProtection

  protect_from_forgery
  before_filter :authenticate_user!

  private

  def current_organization
    current_user.organization
  end

  def is_moderator?
    unless current_user.is?(:moderator)
      render status: :forbidden, text: 'no deal'
    end
  end

  def is_admin?
    unless current_user.is?(:admin)
      render status: :forbidden, text: 'no deal'
    end
  end
end
