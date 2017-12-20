require 'rails_helper'

describe ReviewsController do
  describe "POST create" do
    let(:user) { Fabricate(:user) }
    let(:business) { Fabricate(:business) }
    context "with a signed in user" do
      before do
        session[:user_id] = user.id
      end
      it "creates a new Review model and saves it" do
        count = Review.count
        post :create, params: { review: Fabricate.attributes_for(:review), business_id: business.id }
        expect(Review.count).to eq(count + 1)
      end
      it "does not create a Review if there is no body" do
        count = Review.count
        post :create, params: { review: Fabricate.attributes_for(:review, body: ""), business_id: business.id }
        expect(Review.count).to eq(count)
      end
      it "associates the review with the logged in user" do
        count = Review.count
        post :create, params: { review: Fabricate.attributes_for(:review), business_id: business.id }
        expect(Review.first.user).to eq(user)
      end
      it "associates the review with a business" do
        count = Review.count
        post :create, params: { review: Fabricate.attributes_for(:review), business_id: business.id }
        expect(Review.first.business).to eq(business)
      end
      it "redirects back to the business page with proper input" do
        post :create, params: { review: Fabricate.attributes_for(:review), business_id: business.id }
        expect(response).to redirect_to business_path(business)
      end
      it "re-renders the page if input is invalid" do
        post :create, params: { review: Fabricate.attributes_for(:review, body: ""), business_id: business.id }
        expect(response).to render_template 'businesses/show'
      end
      it "creates a @review variable" do
        post :create, params: { review: Fabricate.attributes_for(:review), business_id: business.id }
        expect(assigns(:review)).to_not be_nil
      end
    end

    context "with a non-signed in user" do
      it "does not create a new Review model" do
        count = Review.count
        post :create, params: { review: Fabricate.attributes_for(:review), business_id: business.id }
        expect(Review.count).to eq(count)
      end
      it "redirects to the login page" do
        post :create, params: { review: Fabricate.attributes_for(:review), business_id: business.id }
        expect(response).to redirect_to login_path
      end
    end
  end
end