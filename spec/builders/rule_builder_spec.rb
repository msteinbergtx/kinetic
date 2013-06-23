require 'spec_helper'

describe RuleBuilder do
  describe '.default_rule' do
    it 'buids a default Rule' do
      rule = RuleBuilder.default_rule

      expect(rule).to be_an_instance_of(Rule)
      expect(rule.calculation_date_engine).
        to be_an_instance_of(Engine::DateOffsetCalculationDate)
      expect(rule.payment_date_engine).
        to be_an_instance_of(Engine::DateOffsetPaymentDate)
      expect(rule.applicability_engine).
        to be_an_instance_of(Engine::BasicApplicability)
      expect(rule.compensation_engine).
        to be_an_instance_of(Engine::BasicCompensation)
    end
  end

  describe '.create_from_params' do
    it 'build a Rule from a request param hash' do
      builder = double('builder')
      rule = double('rule')
      rule.should_receive(:calculation_date_engine=).with(builder)
      rule.should_receive(:payment_date_engine=).with(builder)
      rule.should_receive(:applicability_engine=).with(builder)
      rule.should_receive(:compensation_engine=).with(builder)
      Rule.stub(:new) { rule }
      EngineBuilder.stub(:build) { builder }

      rule = RuleBuilder.create_from_params({}, {})
    end
  end

  describe '.update_from_params' do
    it "update a Rule's engines from a request param hash" do
      builder = double('builder')
      rule = create(:rule, name: 'old name')
      rule.should_receive(:calculation_date_engine=).with(builder)
      rule.should_receive(:payment_date_engine=).with(builder)
      rule.should_receive(:applicability_engine=).with(builder)
      rule.should_receive(:compensation_engine=).with(builder)
      Rule.stub(:find) { rule }
      EngineBuilder.stub(:build) { builder }

      rule = RuleBuilder.update_from_params(rule.id, { name: 'new name' }, {})

      expect(rule.name).to eq 'new name'
    end
  end
end
