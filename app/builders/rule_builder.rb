class RuleBuilder
  def self.default_rule
    rule = Rule.new
    rule.calculation_date_engine = Engine::DateOffsetCalculationDate.new
    rule.payment_date_engine = Engine::DateOffsetPaymentDate.new
    rule.applicability_engine = Engine::BasicApplicability.new
    rule.compensation_engine = Engine::BasicCompensation.new
    rule
  end

  def self.create_from_params(rules_params, params)
    rule = Rule.new(rules_params)
    update_engines(rule, params)
  end

  def self.update_from_params(id, rules_params, params)
    rule = Rule.find(id)
    rule.assign_attributes(rules_params)
    update_engines(rule, params)
  end

  def self.update_engines(rule, params)
    if params[:calculation_date_engine_attributes]
      rule.calculation_date_engine = EngineBuilder.
        build(params[:calculation_date_engine_attributes])
    end

    if params[:payment_date_engine_attributes]
      rule.payment_date_engine = EngineBuilder.
        build(params[:payment_date_engine_attributes])
    end

    if params[:applicability_engine_attributes]
      rule.applicability_engine = EngineBuilder.
        build(params[:applicability_engine_attributes])
    end

    if params[:compensation_engine_attributes]
      rule.compensation_engine = EngineBuilder.
        build(params[:compensation_engine_attributes])
    end

    rule
  end
  private_class_method :update_engines
end
