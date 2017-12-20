require 'rails_helper'

describe Review do
  it { should validate_presence_of :body }
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :business_id }
  it { belong_to :user }
  it { belong_to :business }

  describe "#recent_reviews" do
    it "creates a list of reviews in chronological order" do
      user = Fabricate(:user)
      business = Fabricate(:business)
      review1 = Fabricate(:review, created_at: 10.days.ago, user: user, business: business)
      review2 = Fabricate(:review, created_at: 8.days.ago, user: user, business: business)
      review3 = Fabricate(:review, created_at: 6.days.ago, user: user, business: business)
      review4 = Fabricate(:review, created_at: 4.days.ago, user: user, business: business)
      review5 = Fabricate(:review, created_at: 2.days.ago, user: user, business: business)
      list = Review.recent_reviews
      expect(list).to eq([review5, review4, review3, review2, review1])
    end
    it "returns a list of size equal to size parameter" do
      user = Fabricate(:user)
      business = Fabricate(:business)
      review1 = Fabricate(:review, created_at: 10.days.ago, user: user, business: business)
      review2 = Fabricate(:review, created_at: 8.days.ago, user: user, business: business)
      review3 = Fabricate(:review, created_at: 6.days.ago, user: user, business: business)
      review4 = Fabricate(:review, created_at: 4.days.ago, user: user, business: business)
      review5 = Fabricate(:review, created_at: 2.days.ago, user: user, business: business)
      list = Review.recent_reviews(3)
      expect(list.size).to eq(3)
      list = Review.recent_reviews(1)
      expect(list.size).to eq(1)
    end
    it "returns a list of 5 elements if no size parameter" do
      user = Fabricate(:user)
      business = Fabricate(:business)
      review1 = Fabricate(:review, created_at: 10.days.ago, user: user, business: business)
      review2 = Fabricate(:review, created_at: 8.days.ago, user: user, business: business)
      review3 = Fabricate(:review, created_at: 6.days.ago, user: user, business: business)
      review4 = Fabricate(:review, created_at: 4.days.ago, user: user, business: business)
      review5 = Fabricate(:review, created_at: 2.days.ago, user: user, business: business)
      review6 = Fabricate(:review, created_at: 2.days.ago, user: user, business: business)
      review7 = Fabricate(:review, created_at: 2.days.ago, user: user, business: business)
      review8 = Fabricate(:review, created_at: 2.days.ago, user: user, business: business)
      list = Review.recent_reviews
      expect(list.size).to eq(5)
    end
  end
end