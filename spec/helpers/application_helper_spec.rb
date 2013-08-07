require 'spec_helper'

describe ApplicationHelper, '#format_date' do
  it 'returns a formatted date time or nil if no date is present' do
    expect(format_date).to be_true
  end
end
