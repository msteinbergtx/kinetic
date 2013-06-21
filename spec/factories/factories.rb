FactoryGirl.define do
  factory :user do
    email 'test@email.com'
    password 'password'
    roles_list 'user'
  end

  factory :admin, class: User do
    email 'test@email.com'
    password 'password'
    roles_list 'admin|user'
    association :organization
  end

  factory :moderator, class: User do
    email 'test@email.com'
    password 'password'
    roles_list 'moderator|admin|user'
  end

  factory :commission do
    amount 100.00
    payment_date Date.today
    association :user
  end

  factory :organization do
    name 'My Organization'
  end

  factory :rule do
    name 'test rule'
    active true
    association :organization
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
