require 'spec_helper'

describe Deal do
  it { expect(subject).to validate_presence_of(:name) }
  it { expect(subject).to validate_presence_of(:amount) }
  it { expect(subject).to validate_presence_of(:sell_date) }
  it { expect(subject).to validate_presence_of(:start_date) }
end
