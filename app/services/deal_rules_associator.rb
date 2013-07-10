class DealRulesAssociator
  def self.associate(organization)
    deals_for_rules = {}
    organization.rules.live.each do |rule|
      deals_for_rules[rule] = rule.
        applicability_engine.
        filter_rules(organization.deals.not_associated).load
    end
    deals_for_rules.each_pair do |rule, deals_to_associate|
      set_deal_rules_associated_date(deals_to_associate, rule)
    end
  end

  def self.set_deal_rules_associated_date(deals, rule)
    deals.each do |deal|
      deal.rules_associated_date = Time.now
      deal.save!
      schedule = CommissionSchedule.new(deal: deal, rule: rule)
      schedule.save!
    end
  end
  private_class_method :set_deal_rules_associated_date
end
