require 'spec_helper'

describe Engine::DateOffsetPaymentDate do
  it { expect(subject).to have_one(:rule) }

  it { expect(subject).to validate_presence_of(:event_type) }
  it { expect(subject).to validate_presence_of(:modifier) }
  it { expect(subject).to validate_presence_of(:day_count) }
  it { expect(subject).to ensure_inclusion_of(:modifier).in_array(['+', '-']) }
  it { expect(subject).to ensure_inclusion_of(:event_type).
    in_array(['start_date', 'end_date']) }

  it { expect(subject).to allow_mass_assignment_of(:event_type) }
  it { expect(subject).to allow_mass_assignment_of(:modifier) }
  it { expect(subject).to allow_mass_assignment_of(:day_count) }

  describe '#set_date' do
    it 'returns the payment date' do
      Timecop.freeze do
        engine = build(
          :date_offset_payment_date,
          event_type: 'start_date',
          modifier: '+',
          day_count: 5
        )
        deal = build(:deal, start_date: Time.now)
        schedule = build(:commission_schedule, commission_payment_date: nil)

        engine.set_date(schedule)

        expect(schedule.commission_payment_date).
          to be_within(10).of(deal.start_date + 5.days)
      end
    end
  end
end
