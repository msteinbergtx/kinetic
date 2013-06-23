require 'spec_helper'

describe Commission do
  it { expect(subject).to belong_to(:user) }
  it { expect(subject).to belong_to(:organization) }
  it { expect(subject).to belong_to(:deal) }
  it { expect(subject).to belong_to(:rule) }

  it { expect(subject).to validate_presence_of(:user) }
  it { expect(subject).to validate_presence_of(:payment_date) }
  it { expect(subject).to validate_presence_of(:amount) }
end

