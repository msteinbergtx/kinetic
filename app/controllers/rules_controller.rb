class RulesController < ApplicationController
  before_filter :is_admin?

  def index
    @rules = current_user.organization.rules
  end

  def new
    @rule = RuleBuilder.default_rule
  end

  def create
    @rule = RuleBuilder.create_from_params(rules_params, params[:rule])
    @rule.organization = current_user.organization
    if @rule.save
      redirect_to action: :index
    else
      render :new
    end
  end

  def edit
    @rule = Rule.find(params[:id])
  end

  def update
    @rule = RuleBuilder.update_from_params(
      Rule.find(params[:id]),
      rules_params,
      params[:rule]
    )

    if @rule.save
      redirect_to action: :index
    else
      render :edit
    end
  end

  def destroy
    rule = Rule.find(params[:id])
    rule.destroy
    redirect_to action: :index
  end

  private

  def rules_params
    params.require(:rule).permit(
      :name,
      :start_date,
      :end_date,
      :active
    )
  end
end
