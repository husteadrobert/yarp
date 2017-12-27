require 'rails_helper'

feature "User profile contains user info and reviews" do
  let(:alice) { Fabricate(:user) }

  before do
    Fabricate(:review, user: alice, business: Fabricate(:business))
    Fabricate(:review, user: alice, business: Fabricate(:business))
    Fabricate(:review, user: alice, business: Fabricate(:business))
    sign_in
    visit user_path(alice)
  end

  scenario "User can see another users name and email" do
    expect(page).to have_content(alice.name)
    expect(page).to have_content(alice.email)
  end

  scenario "User can see another users reviews" do
    expect(page).to have_content(alice.reviews.first.body)
    expect(page).to have_content(alice.reviews.first.business.name)
    expect(page).to have_content(alice.reviews.last.body)
    expect(page).to have_content(alice.reviews.last.business.name)
  end

  scenario "User can click on business in users reviews to visit that page" do
    click_link(alice.reviews.first.business.name)
    expect(page).to have_content(alice.reviews.first.business.name)
    expect(page).to have_content(alice.reviews.first.body)
  end
end