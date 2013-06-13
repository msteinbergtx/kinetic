require 'spec_helper'

feature 'sign in', js: true do
  it 'signs a user in' do
    user = build(:user, email: 'britt@test.com')
    user.password = 'test1234'
    user.save!

    visit new_user_session_path
    fill_in 'Email', with: 'britt@test.com'
    fill_in 'Password', with: 'test1234'

    click_button 'Sign in'

    expect(page).to have_content 'Howdy!'
  end
end
