require 'rails_helper'

RSpec.describe 'User Login Page' do
  it 'has fields for username and password' do
    visit login_path
    # save_and_open_page
    expect(page).to have_field('Email:')
    expect(page).to have_field('Password:')
    expect(page).to have_button('Log In')
  end

  it 'takes you to dashboard if unique email and password correct' do
    user1 = User.create(name: "User One", email: "user1@test.com", password: 'password')

    visit login_path

    fill_in "Email:", with: user1.email
    fill_in "Password:", with: user1.password
    click_button "Log In"

    expect(current_path).to eq(user_path(user1.id))
  end

  it 'does not log in if email doesnt exist' do
    visit login_path

    fill_in "Email:", with: "FakeEmail"
    fill_in "Password:", with: "Password"
    click_button "Log In"

    expect(page).to have_field 'Email:', with: 'FakeEmail'
    expect(page).to have_content("You have entered an invalid username or password")
  end

  it 'does not log in if email and password invalid' do
    user1 = User.create(name: "User One", email: "user1@test.com", password: 'password')

    visit login_path

    fill_in "Email:", with: "Not right email"
    fill_in "Password:", with: user1.password
    click_button "Log In"
    expect(page).to have_field 'Email:', with: 'Not right email'
    expect(page).to have_content("You have entered an invalid username or password")
  end
end