require 'spec_helper'

describe Engine::DateOffsetCalculationDate do
  it { expect(subject).to have_one(:rule) }

  it { expect(subject).to validate_presence_of(:event_type) }
  it { expect(subject).to validate_presence_of(:modifier) }
  it { expect(subject).to validate_presence_of(:day_count) }
  it { expect(subject).to ensure_inclusion_of(:modifier).in_array(['+', '-']) }

  it { expect(subject).to allow_mass_assignment_of(:event_type) }
  it { expect(subject).to allow_mass_assignment_of(:modifier) }
  it { expect(subject).to allow_mass_assignment_of(:day_count) }
end
