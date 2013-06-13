class EngineBuilder
  def self.build(params)
    type = params.delete(:type)
    calculation_date_engine = "Engine::#{type}".constantize.create(params)
    calculation_date_engine
  end
end
