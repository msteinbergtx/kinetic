class OrganizationsController < ApplicationController
  before_filter :is_moderator?

  def index
    @organizations = Organization.all
  end

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(organization_params)

    if @organization.save
      redirect_to action: :index
    else
      render :new
    end
  end

  def edit
    @organization = Organization.find(params[:id])
  end

  def update
    @organization = Organization.find(params[:id])

    if @organization.update_attributes(organization_params)
      redirect_to action: :index
    else
      render :edit
    end
  end

  private

  def organization_params
    params.require(:organization).permit(:name)
  end
end
