require 'spec_helper'

describe CommissionCalculator do
  describe '.calculate' do
    it 'calculates commissions for deals' do
      Timecop.freeze do
        rule = create(
          :rule,
          compensation_engine: create(
            :basic_compensation,
            calculation: "[AMT] * 0.25"
          )
        )
        organization = rule.organization
        deal = create(
          :deal,
          name: 'for the test',
          organization: organization
        )
        schedule = create(
          :commission_schedule,
          deal: deal,
          rule: rule,
          commission_payment_date: Time.now + 1.day,
          calculate_commission_date: Time.now - 1.day
        )

        CommissionCalculator.calculate(deal)
        schedule.reload

        expect(deal.commissions.length).to eq 1
        expect(schedule.commission_calculated_date).to eq Time.now
      end
    end

    it 'does not calculate if commissions already exist' do
      rule = create(
        :rule,
        compensation_engine: create(
          :basic_compensation,
          calculation: "[AMT] * 0.25"
        )
      )
      organization = rule.organization
      deal = create(
        :deal,
        name: 'for the test',
        organization: organization,
      )
      create(
        :commission_schedule,
        deal: deal,
        rule: rule,
        commission_calculated_date: Time.now
      )
      create(:commission, deal: deal)

      CommissionCalculator.calculate(deal)

      expect(deal.commissions.length).to eq 1
    end
  end
end
