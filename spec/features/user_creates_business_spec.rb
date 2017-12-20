require 'rails_helper'

feature "Creating a new Business" do
  scenario "User creates a valid Business" do
    alice = Fabricate(:user)
    biz = Fabricate.attributes_for(:business)
    sign_in(alice)
    visit '/businesses/new'
    expect(page).to have_content("Add a new Business")
    #fill_in 'business_name', with: biz[:name]
    fill_in "Business Name", with: biz[:name]
    click_button "Add Business"
    expect(page).to have_content(biz[:name])
  end
  scenario "User creates an invalid Business" do
  end
end


def sign_in(user)
  visit '/login'
  fill_in 'email', with: user.email
  fill_in 'password', with: user.password
  click_button 'Sign In'
end