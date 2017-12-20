require 'rails_helper'

describe PagesController do
  describe "GET front" do
    it "redirects to the home path if logged in" do
      session[:user_id] = Fabricate(:user).id
      get :front
      expect(response).to redirect_to home_path
    end
  end

  describe "GET home" do
    context "with a logged in user" do
      before do
        session[:user_id] = Fabricate(:user).id
      end
      it "creates a @recent_reviews variable" do
        get :home
        expect(assigns(:recent_reviews)).to_not be_nil
      end
    end
  end

end