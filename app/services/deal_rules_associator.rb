class DealRulesAssociator
  def self.associate(organization)
    organization.rules.each do |rule|
      deals = rule.
        applicability_engine.
        filter_rules(organization.deals.not_associated)
      set_deal_rules_associated_date(deals)
      rule.deals = deals
    end
  end

  def self.set_deal_rules_associated_date(deals)
    deals.each do |deal|
      deal.rules_associated_date = Time.now
      deal.save!
    end
  end
  private_class_method :set_deal_rules_associated_date
end
