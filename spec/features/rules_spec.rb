require 'spec_helper'

feature 'User works with Rule', js: true do
  scenario 'creates a rule' do
    user = create(:user)
    login_as(user)

    visit new_rule_path
    fill_in 'Name', with: 'test rule'
    check 'Active'
    fill_in 'Start date', with: Date.today
    fill_in 'End date', with: Date.today + 5

    within '.js-payment-date' do
      fill_in 'Event type', with: 'start'
      fill_in 'Modifier', with: '+'
      fill_in 'Day count', with: 100
    end

    within '.js-calculation-date' do
      fill_in 'Event type', with: 'start'
      fill_in 'Modifier', with: '+'
      fill_in 'Day count', with: 100
    end

    fill_in 'Applies to', with: 'test applies to'
    fill_in 'Commission formula', with: 'test formula'

    click_button 'Create Rule'

    expect(page).to have_content 'Howdy!'
  end

  scenario 'updates an existing Rule' do
    create(:rule, name: 'the old name')
    user = create(:user)
    login_as(user)

    visit rules_path
    click_on 'Edit'
    fill_in 'Name', with: 'the new name'
    click_button 'Update Rule'

    expect(page).to have_content 'the new name'
  end

  scenario 'updates an engine' do
    applicability_engine = create(
      :basic_applicability,
      calculation: 'old calculation'
    )
    create(:rule, applicability_engine: applicability_engine)
    user = create(:user)
    login_as(user)

    visit rules_path
    click_on 'Edit'
    fill_in 'Applies to', with: 'new calculation'
    click_button 'Update Rule'
    click_on 'Edit'

    expect(find_field('Applies to').value).to eq 'new calculation'
  end
end
