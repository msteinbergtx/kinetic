require 'spec_helper'

feature 'Organization management', js: true do
  scenario 'creating an Organization' do
    user = create(:moderator)
    login_as(user)

    visit new_organization_path
    fill_in 'Name', with: 'test organization'
    click_button 'Create Organization'

    expect(page).to have_content('Organizations')
    expect(page).to have_content('test organization')
  end

  scenario 'updateing an Organization' do
    user = create(:moderator)
    organization = create(:organization, name: 'old org name')
    login_as(user)

    visit edit_organization_path(organization)
    fill_in 'Name', with: 'new org name'
    click_button 'Update Organization'

    expect(page).to have_content('Organizations')
    expect(page).to have_content('new org name')
  end

  scenario 'can only be done by moderators' do
    user = create(:admin)
    login_as(user)

    visit new_organization_path

    expect(page).to have_content('no deal')
  end
end
