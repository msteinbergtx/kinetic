require 'spec_helper'

feature 'sign in', js: true do
  it 'signs a user in' do
    user = create(:user, email: 'britt@test.com', password: 'test1234')
    visit new_user_session_path
    ap User.last
    fill_in 'Email', with: 'britt@test.com'
    fill_in 'Password', with: 'test1234'

    click_button 'Sign in'

    expect(page).to have_content 'Howdy!'
  end
end
