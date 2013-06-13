require 'spec_helper'

describe EngineBuilder do
  describe '.build' do
    it 'creates an instance of an Engine' do
      type = 'BasicApplicability'

      engine = EngineBuilder.build({ type: type, calculation: 'test' })

      expect(engine).to be_an_instance_of(Engine::BasicApplicability)
    end
  end
end
