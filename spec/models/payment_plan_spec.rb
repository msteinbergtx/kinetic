require 'spec_helper'

describe PaymentPlan do
  it { expect(subject).to belong_to :user }

  it { expect(subject).to validate_presence_of :user }
end
