require 'spec_helper'

describe Engine::BasicApplicability do
  it { expect(subject).to have_one(:rule) }

  it { expect(subject).to validate_presence_of(:calculation) }

  it { expect(subject).to allow_mass_assignment_of(:calculation) }
end
