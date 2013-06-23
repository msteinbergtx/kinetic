require 'spec_helper'

describe Engine::BasicApplicability do
  it { expect(subject).to have_one(:rule) }

  it { expect(subject).to validate_presence_of(:calculation) }

  it { expect(subject).to allow_mass_assignment_of(:calculation) }

  describe '#filter_rules' do
    it 'returns deals that the rule applies to' do
      applicability = build(:basic_applicability, calculation: '1 = 1')
      deals = double('deals')
      deals.should_receive(:where).with('1 = 1')

      applicability.filter_rules(deals)
    end
  end
end
