FactoryGirl.define do
  sequence :email do |count|
    "test#{count}@email.com"
  end

  factory :user do
    email
    password 'password'
    roles ['user']
    association :organization

    before(:create) do |user|
      create(:organization)
    end
  end

  factory :admin, class: User do
    email
    password 'password'
    roles ['admin','user']
    association :organization
  end

  factory :moderator, class: User do
    email
    password 'password'
    roles ['admin','user','moderator']
    association :organization
  end

  factory :commission do
    amount 100.00
    payment_date Date.today
    association :user
    association :organization
  end

  factory :organization do
    name 'My Organization'
  end

  factory :rule do
    name 'test rule'
    active true
    association :organization
    association :applicability_engine, factory: :basic_applicability
    association :compensation_engine, factory: :basic_compensation
    association :calculation_date_engine, factory: :date_offset_calculation_date
    association :payment_date_engine, factory: :date_offset_payment_date
  end

  factory :deal do
    name 'test deal'
    details {{ "amount" => "100.00" }}
    association :user
    association :organization
  end

  factory :commission_schedule do
    association :rule
    association :deal
  end

  factory :basic_applicability, class: Engine::BasicApplicability do
    calculation 'basic calculation'
  end

  factory :basic_compensation, class: Engine::BasicCompensation do
    calculation 'basic payment amount'
  end

  factory :date_offset_calculation_date, class: Engine::DateOffsetCalculationDate do
    event_type 'start_date'
    modifier '+'
    day_count 5
  end

  factory :date_offset_payment_date, class: Engine::DateOffsetPaymentDate do
    event_type 'end_date'
    modifier '+'
    day_count 5
  end
end
