require 'spec_helper'

feature 'commissiosn', js: true do
  scenario 'a broker logs in' do
    user = create(:admin, roles: ['user'])
    commission = build(:commission, amount: 500)
    create(:commission, amount: 600)
    user.commissions << commission
    login_as(user)
    visit root_path

    expect(page).to have_content(500)
    expect(page).not_to have_content(600)
  end
end
