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

      rule = RuleBuilder.create_from_params(
        {},
        {
          compensation_engine_attributes: {},
          calculation_date_engine_attributes: {},
          payment_date_engine_attributes: {},
          applicability_engine_attributes: {},
        }
      )
    end
  end

  describe '.update_from_params' do
    it "update a applicability engine from a request param hash" do
      builder = double('builder')
      rule = create(:rule, name: 'old name')
      rule.should_receive(:compensation_engine=).with(builder)
      rule.should_not_receive(:payment_date_engine=).with(builder)
      rule.should_not_receive(:applicability_engine=).with(builder)
      rule.should_not_receive(:calculation_date_engine=).with(builder)
      Rule.stub(:find) { rule }
      EngineBuilder.stub(:build) { builder }

      rule = RuleBuilder.update_from_params(
        rule.id,
        { name: 'new name' },
        { compensation_engine_attributes: {} }
      )

      expect(rule.name).to eq 'new name'
    end

    it "update a applicability engine from a request param hash" do
      builder = double('builder')
      rule = create(:rule, name: 'old name')
      rule.should_receive(:applicability_engine=).with(builder)
      Rule.stub(:find) { rule }
      EngineBuilder.stub(:build) { builder }

      rule = RuleBuilder.update_from_params(
        rule.id,
        { name: 'new name' },
        { applicability_engine_attributes: {} }
      )

      expect(rule.name).to eq 'new name'
    end

    it "update a payment date engine from a request param hash" do
      builder = double('builder')
      rule = create(:rule, name: 'old name')
      rule.should_receive(:payment_date_engine=).with(builder)
      Rule.stub(:find) { rule }
      EngineBuilder.stub(:build) { builder }

      rule = RuleBuilder.update_from_params(
        rule.id,
        { name: 'new name' },
        { payment_date_engine_attributes: {} }
      )

      expect(rule.name).to eq 'new name'
    end

    it "update a calculation date engine from a request param hash" do
      builder = double('builder')
      rule = create(:rule, name: 'old name')
      rule.should_receive(:calculation_date_engine=).with(builder)
      Rule.stub(:find) { rule }
      EngineBuilder.stub(:build) { builder }

      rule = RuleBuilder.update_from_params(
        rule.id,
        { name: 'new name' },
        { calculation_date_engine_attributes: {} }
      )

      expect(rule.name).to eq 'new name'
    end
  end
end
