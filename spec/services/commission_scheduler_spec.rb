require 'spec_helper'

describe CommissionScheduler do
  describe '.schedule_payment_date' do
    it 'assigns payment date' do
      Timecop.freeze do
        rule = create(
          :rule,
          payment_date_engine: create(
            :date_offset_payment_date,
            event_type: 'start_date',
            modifier: '+',
            day_count: 7
          )
        )
        deal = create(
          :deal,
          details: { 'start_date' => (DateTime.now + 10.days).to_s }
        )
        schedule = create(:commission_schedule, deal: deal, rule: rule)

        CommissionScheduler.schedule_payment_date(schedule)

        expect(schedule.commission_payment_date).to be_within(1).of(DateTime.now + 10.days + 7.days)
      end
    end
  end

  describe '.schedule_calculation_date' do
    it 'assigns payment date' do
      Timecop.freeze do
        rule = create(
          :rule,
          calculation_date_engine: create(
            :date_offset_calculation_date,
            event_type: 'start_date',
            modifier: '+',
            day_count: 4
          )
        )
        deal = create(:deal, details: { 'start_date' => (DateTime.now + 18.days).to_s })
        schedule = create(:commission_schedule, deal: deal, rule: rule)

        CommissionScheduler.schedule_calculation_date(schedule)

        expect(schedule.calculate_commission_date).
          to be_within(1).of(DateTime.now + 18.days + 4.days)
      end
    end
  end
end
