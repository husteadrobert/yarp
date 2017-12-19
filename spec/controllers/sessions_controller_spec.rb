require 'rails_helper'

describe SessionsController do

  describe "GET new" do
    it "displays the login page" do
      get :new
      expect(response).to render_template('new')
    end
    it "redirects to the root path if already logged in" do
      session[:user_id] = Fabricate(:user).id
      get :new
      expect(response).to redirect_to root_path
    end
  end

  describe "POST create" do
    context "with valid credentials" do
      it "redirects to the root path" do
        user = Fabricate(:user)
        post :create, params: {email: user.email, password: user.password}
        expect(response).to redirect_to root_path
      end
      it "puts the current_user in the session" do
        user = Fabricate(:user)
        post :create, params: {email: user.email, password: user.password}
        expect(session[:user_id]).to eq(user.id)
      end
    end
    context "with invalid credentials" do
      it "redirects to the login page" do
        user = Fabricate(:user)
        post :create, params: {email: user.email, password: "lolno" }
        expect(response).to redirect_to login_path
      end
      it "does not set the current_user in the sessin" do
        user = Fabricate(:user)
        post :create, params: {email: user.email, password: "lolno" }
        expect(session[:user_id]).to_not eq(user.id)
      end
    end
  end

  describe "GET destroy" do
    it "sets the session id to nil" do
      session[:user_id] = Fabricate(:user).id
      get :destroy
      expect(session[:user_id]).to be_nil
    end
    it "redirects to the root path" do
      session[:user_id] = Fabricate(:user).id
      get :destroy
      expect(response).to redirect_to root_path
    end
  end

end