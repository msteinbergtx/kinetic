require 'spec_helper'

describe Payment do
  it { expect(subject).to belong_to(:user) }
  it { expect(subject).to belong_to(:commission) }

  it { expect(subject).to validate_presence_of(:amount) }
  it { expect(subject).to validate_presence_of(:payment_date) }
  it { expect(subject).to validate_presence_of(:user) }
  it { expect(subject).to validate_presence_of(:commission) }
end
