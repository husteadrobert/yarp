require 'rails_helper'

feature "Creating a new Business" do
  scenario "User creates a valid Business" do
    alice = Fabricate(:user)
    biz = Fabricate.attributes_for(:business)
    sign_in(alice)
    visit '/businesses/new'
    expect(page).to have_content("Add a new Business")
    fill_in "Business Name", with: biz[:name]
    click_button "Add Business"
    expect(page).to have_content(biz[:name])
  end
  scenario "User creates an invalid Business" do
    alice = Fabricate(:user)
    biz = Fabricate.attributes_for(:business, name: "")
    sign_in(alice)
    visit '/businesses/new'
    fill_in "Business Name", with: biz[:name]
    click_button "Add Business"
    expect(page).to have_content("Something went wrong")
  end
  scenario "User trys to visit create business page while not signed in" do
    visit '/businesses/new'
    expect(page).to have_content("Sign In")
  end
end