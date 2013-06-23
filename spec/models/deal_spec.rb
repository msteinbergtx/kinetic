require 'spec_helper'

describe Deal do
  it { expect(subject).to belong_to(:user) }
  it { expect(subject).to belong_to(:organization) }

  it { expect(subject).to have_many(:commission_schedules) }
  it { expect(subject).to have_many(:rules).through(:commission_schedules) }

  it { expect(subject).to have_many(:commissions) }

  it { expect(subject).to validate_presence_of(:name) }
  it { expect(subject).to validate_presence_of(:amount) }
  it { expect(subject).to validate_presence_of(:sell_date) }
  it { expect(subject).to validate_presence_of(:user) }

  describe '.not_associated' do
    it 'returns deals that have not been associated with rules' do
      deal = create(:deal, rules_associated_date: nil)
      create(:deal, rules_associated_date: Time.now)

      deals = Deal.not_associated

      expect(deals).to eq [deal]
    end
  end
end
