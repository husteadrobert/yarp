require 'rails_helper'

describe UsersController do
  describe "GET new" do
    it "sets up the @user variable" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "POST create" do
    it "creates a new user from login variables" do
      count = User.count
      post :create, params: {user: Fabricate.attributes_for(:user)}
      #post :create, user: Fabricate.attributes_for(:user)
      expect(User.count).to eq(count + 1)
    end
    it "redirects to the login page" do
      post :create, params: {user: Fabricate.attributes_for(:user)}
      expect(response).to redirect_to login_path
    end
    it "does not redirect if variables are invalid" do
      user = Fabricate.attributes_for(:user, name: "")
      post :create, params: {user: user}
      expect(response).to_not redirect_to login_path
    end
    it "does not create a new user if variables are invalid" do
      count = User.count
      post :create, params: {user: Fabricate.attributes_for(:user, name: "")}
      expect(User.count).to eq(count)
    end
    it "renders 'new' template if user is invalid" do
      post :create, params: {user: Fabricate.attributes_for(:user, name: "")}
      expect(response).to render_template('new')
    end
    it "creates a @user variable" do
      post :create, params: {user: {name: "What?"}}
      expect(assigns(:user).name).to eq("What?")
    end
  end

end