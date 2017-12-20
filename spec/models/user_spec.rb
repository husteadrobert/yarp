require 'rails_helper'


describe User do
  it { should validate_presence_of :email }
  it { should validate_presence_of :name }
  it { should validate_presence_of :password }
  it { should validate_uniqueness_of :email }
  it { have_many :reviews }

  describe "#has_reviewed?" do
    it "returns true if user has reviewed a business before" do
      user = Fabricate(:user)
      business = Fabricate(:business)
      review = Fabricate(:review, user: user, business: business)
      expect(user.has_reviewed?(business)).to be_truthy
    end
    it "returns false if the user has not reviewed a business before" do
      user = Fabricate(:user)
      business = Fabricate(:business)
      expect(user.has_reviewed?(business)).to be_falsey
    end
  end
end