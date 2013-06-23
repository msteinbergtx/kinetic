require 'spec_helper'

describe DealRulesAssociator do
  describe '.associate' do
    it 'associates rules with deals' do
      rule = create(
        :rule,
        applicability_engine: create(
          :basic_applicability,
          calculation: "name = 'for the test'"
        )
      )
      organization = rule.organization
      deal = create(:deal, name: 'for the test', organization: organization)
      create(:deal, name: 'no for the test', organization: organization)
      create(
        :deal,
        name: 'for the test',
        organization: organization,
        rules_associated_date: Time.now
      )

      DealRulesAssociator.associate(organization)

      expect(rule.deals).to eq [deal]
      expect(rule.deals.first.rules_associated_date).not_to be_nil
    end
  end
end
