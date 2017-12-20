require 'rails_helper'

feature "Sign In" do
  scenario "Sign In with correct credentials" do
    visit '/login'
    alice = Fabricate(:user)
    fill_in 'email', with: alice.email
    fill_in 'password', with: alice.password
    click_button 'Sign In'
    expect(page).to have_content(alice.name)
  end
  scenario "Sign In without correct credentials" do
    visit '/login'
    alice = Fabricate(:user)
    fill_in 'email', with: alice.email
    fill_in 'password', with: "LOLNO!"
    click_button 'Sign In'
    expect(page).to have_content("problem")
  end
  scenario "Try to access Sign in page when already logged in" do
    visit '/login'
    alice = Fabricate(:user)
    fill_in 'email', with: alice.email
    fill_in 'password', with: alice.password
    click_button 'Sign In'
    visit '/login'
    expect(page).to_not have_content("Password")
  end
  scenario "Log out" do
    visit '/login'
    alice = Fabricate(:user)
    fill_in 'email', with: alice.email
    fill_in 'password', with: alice.password
    click_button 'Sign In'
    click_link 'Logout'
    expect(page).to_not have_content(alice.name)
  end
end