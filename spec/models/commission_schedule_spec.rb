require 'spec_helper'

describe CommissionSchedule do
  it { expect(subject).to belong_to(:rule) }
  it { expect(subject).to belong_to(:deal) }

  it { expect(subject).to validate_presence_of(:rule) }
  it { expect(subject).to validate_presence_of(:deal) }

  describe '.pending_payment' do
    it 'returns schedules that have not already been paid' do
      schedule = create(
        :commission_schedule,
        commission_calculated_date: nil,
        calculate_commission_date: Time.now - 1.day
      )
      create(
        :commission_schedule,
        commission_calculated_date: Time.now,
        calculate_commission_date: Time.now - 1.day
      )

      schedules = CommissionSchedule.pending_calculation

      expect(schedules.length).to eq 1
      expect(schedules.first).to eq schedule
    end

    it 'returns schedules that have not already been paid and are due' do
      schedule = create(
        :commission_schedule,
        commission_calculated_date: nil,
        calculate_commission_date: Time.now - 1.day
      )
      create(
        :commission_schedule,
        commission_calculated_date: nil,
        calculate_commission_date: Time.now + 1.day
      )

      schedules = CommissionSchedule.pending_calculation

      expect(schedules.length).to eq 1
      expect(schedules.first).to eq schedule
    end
  end

  describe '#set_calculation_date' do
    it 'calls the calculation date engine for a rule' do
      engine = double('calculation_date_engine')
      engine.should_receive(:set_date)
      schedule = build(:commission_schedule)
      schedule.rule.should_receive(:calculation_date_engine).and_return(engine)

      schedule.set_calculation_date
    end
  end

  describe '#set_payment_date' do
    it 'calls the payment date engine for a rule' do
      engine = double('payment_date_engine')
      engine.should_receive(:set_date)
      schedule = build(:commission_schedule)
      schedule.rule.should_receive(:payment_date_engine).and_return(engine)

      schedule.set_payment_date
    end
  end

  describe '#calculate_commission' do
    it 'calls the compensation engine for a rule' do
      compensation_engine = double('compensation_engine')
      commission_schedule = build(:commission_schedule)
      compensation_engine.should_receive(:compensate).
        with(commission_schedule)
      commission_schedule.rule.
        should_receive(:compensation_engine).
        and_return(compensation_engine)

      Timecop.freeze do
        commission_schedule.calculate_commission

        expect(commission_schedule.commission_calculated_date).to eq Time.now
      end
    end
  end

  describe '#commission_calculated?' do
    it 'returns true if the commission has been calculated' do
      commission_schedule = build(
        :commission_schedule,
        commission_calculated_date: Time.now
      )

      expect(commission_schedule.commission_calculated?).to be_true
    end

    it 'returns false if the commission has not been calculated' do
      commission_schedule = build(
        :commission_schedule
      )

      expect(commission_schedule.commission_calculated?).to be_false
    end
  end
end
