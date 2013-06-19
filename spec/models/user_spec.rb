require 'spec_helper'

describe User do
  it { expect(subject).to have_many(:commissions) }
end
