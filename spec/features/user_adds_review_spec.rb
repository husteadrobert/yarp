require 'rails_helper'

feature "Adding a review to a business" do
  let(:alice) { Fabricate(:user) }
  let(:biz) { Fabricate(:business) }

  scenario "User adds a valid text review to a business" do
    sign_in(alice)
    visit business_path(biz)
    fill_in 'review_body', with: Fabricate.attributes_for(:review)
    click_button "Submit Review"
    expect(page).to have_content("Thank you")
  end

  scenario "User can not add another review to a business they have already reviewed" do
    sign_in(alice)
    review = Fabricate(:review, user: alice, business: biz)
    visit business_path(biz)
    expect(page).to have_content("Thank you")
    expect(page).to have_content(review.body)
    expect(page).to_not have_content("Write your Review here")
  end

end
