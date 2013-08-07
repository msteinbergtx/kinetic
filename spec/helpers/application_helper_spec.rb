require 'spec_helper'

describe ApplicationHelper, '#format_date' do
  it 'returns a formatted date time if a valid date time is passed; sample date is 03/01/1980' do
    rawdate = Time.new(1980, 3, 1)

    formatted_date = format_date(rawdate)

    expect(formatted_date).to eq '03/01/1980'
  end

  it 'does not return an error if a nil date is passed' do
    nildate = nil

    formatted_date = format_date(nildate)

    expect(formatted_date).to eq ''
  end
end
