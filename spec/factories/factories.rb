FactoryGirl.define do
  factory :user do
    email 'test@email.com'
    password 'password'
  end

  factory :rule do
    name 'test rule'
    active true
    association :applicability_engine, factory: :basic_applicability
    association :payment_amount_engine, factory: :basic_payment_amount
    association :calculation_date_engine, factory: :date_offset_calculation_date
    association :payment_date_engine, factory: :date_offset_payment_date
  end

  factory :basic_applicability, class: Engine::BasicApplicability do
    calculation 'basic calculation'
  end

  factory :basic_payment_amount, class: Engine::BasicPaymentAmount do
    calculation 'basic payment amount'
  end

  factory :date_offset_calculation_date, class: Engine::DateOffsetCalculationDate do
    event_type 'test event type'
    modifier '+'
    day_count 5
  end

  factory :date_offset_payment_date, class: Engine::DateOffsetPaymentDate do
    event_type 'test event type'
    modifier '+'
    day_count 5
  end
end
