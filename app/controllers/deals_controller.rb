class DealsController < ApplicationController
  before_filter :is_moderator?

  def index
    @deals = Deal.all
    @scheduled_commissions = CommissionSchedule.all
    @commissions = Commission.all
  end

  def new
    @deal = Deal.new
    @users = User.all
  end

  def create
    @deal = Deal.new(deal_params)

    if @deal.save
      redirect_to action: :index
    else
      @users = User.all
      render :new
    end
  end

  def associate
    deal = Deal.find(params[:id])
    redirect_to action: :index
  end

  def schedule
    deal = Deal.find(params[:id])
    deal.commission_schedules.each do |schedule|
      CommissionScheduler.schedule_payment_date(schedule)
      CommissionScheduler.schedule_calculation_date(schedule)
    end
    redirect_to action: :index
  end

  def calculate
    deal = Deal.find(params[:id])
    CommissionCalculator.calculate(deal)
    redirect_to action: :index
  end

  private

  def deal_params
    params.require(:deal).permit(
      :name,
      :sell_date,
      :start_date,
      :end_date,
      :organization_id,
      :user_id,
      :amount
    )
  end
end
