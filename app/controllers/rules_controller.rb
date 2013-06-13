class RulesController < ApplicationController
  def index
    @rules = Rule.all
  end

  def new
    @rule = RuleBuilder.default_rule
  end

  def create
    @rule = RuleBuilder.create_from_params(rules_params, params[:rule])
    if @rule.save
      redirect_to root_path
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
      @rules = Rule.all
      render :index
    else
      render :edit
    end
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
