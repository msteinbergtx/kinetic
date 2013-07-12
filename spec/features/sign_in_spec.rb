require 'spec_helper'

feature 'User Sessions', js: true do
  scenario 'tries to access the site without signing in' do
    visit new_rule_path

    expect(page).to have_content 'You need to sign in or sign up before continuing'
  end

  scenario 'User signs in' do
    user = create(:user, email: 'britt@test.com', password: 'test1234')

    visit new_user_session_path
    fill_in 'Email', with: 'britt@test.com'
    fill_in 'Password', with: 'test1234'

    click_button 'Sign in'

    expect(page).to have_content 'Home'
  end

  scenario 'Admin signs in' do
    user = create(:admin, email: 'britt@test.com', password: 'test1234')

    visit new_user_session_path
    fill_in 'Email', with: 'britt@test.com'
    fill_in 'Password', with: 'test1234'

    click_button 'Sign in'

    expect(page).to have_content 'Home'
    expect(page).to have_link 'Commission rules'
  end

  scenario 'Broker signs in' do
    user = create(:user, email: 'britt@test.com', password: 'test1234')

    visit new_user_session_path
    fill_in 'Email', with: 'britt@test.com'
    fill_in 'Password', with: 'test1234'

    click_button 'Sign in'

    expect(page).to have_content 'Home'
    expect(page).to have_content 'You have no commissions'
  end

  scenario 'Broker signs in with Commissions' do
    user = create(:user, email: 'britt@test.com', password: 'test1234')
    create(:commission, amount: 150.00)
    create(:commission, amount: 200.00, user: user)

    visit new_user_session_path
    fill_in 'Email', with: 'britt@test.com'
    fill_in 'Password', with: 'test1234'

    click_button 'Sign in'

    expect(page).to have_content 'Home'
    expect(page).to have_content '$200.00'
    expect(page).not_to have_content '$150.00'
  end

  scenario 'User registers' do
    visit new_user_registration_path

    fill_in 'Email', with: 'britt@test.com'
    fill_in 'Password', with: 'test1234'
    fill_in 'Password confirmation', with: 'test1234'

    click_button 'Sign up'

    expect(page).to have_content 'Home'
    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end

  scenario 'User signs out' do
    user = build(:user, email: 'britt@test.com')

    login_as(user)
    visit root_path
    click_link 'Sign out'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
