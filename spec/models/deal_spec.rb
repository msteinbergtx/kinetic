require 'spec_helper'

describe Deal do
  it { expect(subject).to belong_to(:user) }
  it { expect(subject).to belong_to(:organization) }

  it { expect(subject).to have_many(:commission_schedules) }
  it { expect(subject).to have_many(:rules).through(:commission_schedules) }

  it { expect(subject).to have_many(:commissions) }

  it { expect(subject).to validate_presence_of(:name) }
  it { expect(subject).to validate_presence_of(:user) }
  it { expect(subject).to validate_presence_of(:details) }

  describe '.not_associated' do
    it 'returns deals that have not been associated with rules' do
      deal = create(:deal, rules_associated_date: nil)
      create(:deal, rules_associated_date: Time.now)

      deals = Deal.not_associated

      expect(deals).to eq [deal]
    end
  end

  describe '#get_decimal' do
    it 'returns a detail converted to a decimal' do
      deal = build(:deal, details: { 'test' => '110.00' })

      value = deal.get_decimal(:test)

      expect(value).to eq 110.00
    end

    it 'returns nil when the key is not in the details hash' do
      deal = build(:deal, details: { 'test' => '110.00' })

      value = deal.get_decimal(:test2)

      expect(value).to be_nil
    end
  end

  describe '#get_datetime' do
    it 'returns a detail converted to a datetime' do
      now = DateTime.now
      deal = build(:deal, details: { 'test' => now.to_s })

      value = deal.get_datetime(:test)

      expect(value).to be_within(1).of(now)
    end

    it 'returns nil when the key is not in the details hash' do
      deal = build(:deal, details: { 'test' => '110.00' })

      value = deal.get_datetime(:test2)

      expect(value).to be_nil
    end
  end
end
