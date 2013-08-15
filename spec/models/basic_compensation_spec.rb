require 'spec_helper'

describe Engine::BasicCompensation do
  it { expect(subject).to have_one(:rule) }

  it { expect(subject).to validate_presence_of(:calculation) }

  it { expect(subject).to allow_mass_assignment_of(:calculation) }

  describe '#compensate' do
    it 'creates a Commission for the user' do
      Timecop.freeze do
        deal = create(
          :deal,
          details: {
            'amount' => 100.to_s,
            'amount2' => 3.to_s
          }
        )
        rule = create(
          :rule,
          compensation_engine: create(
            :basic_compensation,
            calculation: '[amount] * 0.25 + [amount2] + 5'
          )
        )
        schedule = create(
          :commission_schedule,
          rule: rule,
          deal: deal,
          commission_payment_date: Time.now
        )

        commission = double('commission')
        commission.should_receive(:save!)
        Commission.should_receive(:new).with(
          amount: 33,
          user: deal.user,
          organization: deal.organization,
          payment_date: Time.now,
          deal: deal,
          rule: rule
        ).and_return(commission)

        rule.compensation_engine.compensate(schedule)
      end
    end
  end
end
