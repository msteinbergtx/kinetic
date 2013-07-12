require 'spec_helper'

feature 'Admin works with Rule', js: true do
  scenario 'creates a rule' do
    user = create(:admin)
    login_as(user)

    visit new_rule_path
    fill_in 'Name', with: 'test rule'
    check 'Active'
    fill_in 'Start date', with: Date.today
    fill_in 'End date', with: Date.today + 5

    within '.js-payment-date' do
      fill_in 'Event type', with: 'start_date'
      fill_in 'Modifier', with: '+'
      fill_in 'Day count', with: 100
    end

    within '.js-calculation-date' do
      fill_in 'Event type', with: 'start_date'
      fill_in 'Modifier', with: '+'
      fill_in 'Day count', with: 100
    end

    fill_in 'Applies to', with: 'test applies to'
    fill_in 'Commission formula', with: 'test formula'

    click_button 'Create Rule'

    expect(page).to have_content 'Commissions Rules'
  end

  scenario 'updates an existing Rule' do
    rule = create(:rule, name: 'the old name')
    user = create(:admin, organization: rule.organization)
    login_as(user)

    visit rules_path
    click_on 'Edit'
    fill_in 'Name', with: 'the new name'
    click_button 'Update Rule'

    expect(page).to have_content 'the new name'
  end

  scenario 'updates an existing Rule that is associated with a Deal' do
    rule = create(:rule, name: 'the old name')
    deal = create(:deal)
    rule.deals << deal
    user = create(:admin, organization: rule.organization)
    login_as(user)

    visit rules_path
    click_on 'Edit'

    expect(page).to have_content('This rule is already associated with deals and cannot be modified.')
  end

  scenario 'updates an engine' do
    applicability_engine = create(
      :basic_applicability,
      calculation: 'old calculation'
    )
    rule = create(:rule, applicability_engine: applicability_engine, deals: [])
    user = create(:admin, organization: rule.organization)
    login_as(user)

    visit rules_path
    click_on 'Edit'
    fill_in 'Applies to', with: 'new calculation'
    click_button 'Update Rule'
    click_on 'Edit'

    expect(find_field('Applies to').value).to eq 'new calculation'
  end

  scenario 'only shows a user rules from their organization' do
    organization = create(:organization)
    user = create(:admin, organization: organization)
    create(:rule, name: 'part of my org', organization: organization)
    create(:rule, name: 'not part of my org')
    login_as(user)

    visit rules_path

    expect(page).to have_content 'part of my org'
    expect(page).not_to have_content 'not part of my org'
  end

  scenario 'delete a rule' do
    organization = create(:organization)
    user = create(:admin, organization: organization)
    create(:rule, active: true, name: 'delete me', organization: organization)
    login_as(user)

    visit rules_path
    click_on 'Deactivate'

    expect(page).not_to have_content 'delete me'
  end
end
