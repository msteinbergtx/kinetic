require 'spec_helper'

feature 'User Sessions', js: true do
  scenario 'signs a user in' do
    user = build(:user, email: 'britt@test.com')
    user.password = 'test1234'
    user.save!

    visit new_user_session_path
    fill_in 'Email', with: 'britt@test.com'
    fill_in 'Password', with: 'test1234'

    click_button 'Sign in'

    expect(page).to have_content 'Howdy!'
  end

  scenario 'User registers' do
    visit new_user_registration_path

    fill_in 'Email', with: 'britt@test.com'
    fill_in 'Password', with: 'test1234'
    fill_in 'Password confirmation', with: 'test1234'

    click_button 'Sign up'

    expect(page).to have_content 'Howdy!'
    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end

  scenario 'User signs out' do
    user = build(:user, email: 'britt@test.com')
    user.password = 'test1234'
    user.save!

    login_as(user)
    visit root_path
    click_link 'Sign out'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
