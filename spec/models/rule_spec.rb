require 'spec_helper'

describe Rule do
  it { expect(subject).to belong_to(:applicability_engine) }
  it { expect(subject).to belong_to(:calculation_date_engine) }
  it { expect(subject).to belong_to(:payment_amount_engine) }
  it { expect(subject).to belong_to(:payment_date_engine) }

  it { expect(subject).to validate_presence_of(:name) }
end
