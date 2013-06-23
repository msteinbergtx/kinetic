require 'spec_helper'

describe Organization do
  it { expect(subject).to have_many(:users) }
  it { expect(subject).to have_many(:rules) }
  it { expect(subject).to have_many(:deals) }

  it { expect(subject).to validate_presence_of(:name) }
end
