require 'spec_helper'

describe DealRulesAssociator do
  describe '.associate' do
    it 'associates rules with deals' do
      rule = create(
        :rule,
        applicability_engine: create(
          :basic_applicability,
          calculation: "name = name:[for the test]"
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

    it 'can handle multiple values combined with AND' do
      rule = create(
        :rule,
        active: true,
        start_date: nil,
        end_date: nil,
        applicability_engine: create(
          :basic_applicability,
          calculation: "amount >= amount:[500] AND amount <= amount:[700]"
        )
      )
      organization = rule.organization
      deal = create(:deal, amount: 700, organization: organization)

      DealRulesAssociator.associate(organization)

      expect(rule.deals).to eq [deal]
      expect(deal.rules.first).to eq rule
    end

    it 'only considers live rules' do
      rule = create(
        :rule,
        active: true,
        start_date: nil,
        end_date: nil,
        applicability_engine: create(
          :basic_applicability,
          calculation: "name = name:[for the test]"
        )
      )
      organization = rule.organization
      create(:rule, active: false, organization: organization)
      deal = create(:deal, name: 'for the test', organization: organization)

      DealRulesAssociator.associate(organization)

      expect(deal.rules.length).to eq 1
      expect(deal.rules.first).to eq rule
    end
  end
end
