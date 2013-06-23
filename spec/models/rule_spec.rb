require 'spec_helper'

describe Rule do
  it { expect(subject).to belong_to(:applicability_engine) }
  it { expect(subject).to belong_to(:calculation_date_engine) }
  it { expect(subject).to belong_to(:compensation_engine) }
  it { expect(subject).to belong_to(:payment_date_engine) }
  it { expect(subject).to belong_to(:organization) }

  it { expect(subject).to have_many(:commission_schedules) }
  it { expect(subject).to have_many(:deals).through(:commission_schedules) }

  it { expect(subject).to validate_presence_of(:name) }
end
