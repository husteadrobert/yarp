require 'rails_helper'

describe BusinessesController do
  describe 'GET index' do
    it "loads all businesses into @bussinesses" do
      biz1 = Fabricate(:business)
      biz2 = Fabricate(:business)
      biz3 = Fabricate(:business)
      get :index
      expect(assigns(:businesses).size).to eq(3)
    end
    it "is ordered from most recently added/updated to oldest" do
      biz1 = Fabricate(:business, created_at: 10.days.ago)
      biz2 = Fabricate(:business, created_at: 9.days.ago)
      biz3 = Fabricate(:business, created_at: 8.days.ago)
      get :index
      expect(assigns(:businesses)[0]).to eq(biz3)
      expect(assigns(:businesses)[1]).to eq(biz2)
      expect(assigns(:businesses)[2]).to eq(biz1)
      biz1.updated_at = 2.days.ago
      biz2.updated_at = 3.days.ago
      biz1.save
      biz2.save
      get :index
      expect(assigns(:businesses)[0]).to eq(biz3)
      expect(assigns(:businesses)[1]).to eq(biz1)
      expect(assigns(:businesses)[2]).to eq(biz2)
    end
  end

  describe 'GET new' do
    context "with logged in user" do
      before do
        session[:user_id] = Fabricate(:user).id
      end
      it "sets up the @business variable" do
        get :new
        expect(assigns(:business)).to be_a_new(Business)
      end
    end
    context "with non-logged in user" do
      it "redirects to the login page" do
        get :new
        expect(response).to redirect_to login_path
      end
    end
  end

  describe 'POST create' do
    context "with logged in user" do
      before do
        session[:user_id] = Fabricate(:user).id
      end
      it "redirects to the individual business page" do
        biz = Fabricate.attributes_for(:business)
        post :create, params: {business: biz}
        new_biz = Business.find_by(name: biz[:name])
        expect(response).to redirect_to business_path(new_biz)
      end
      it "re-renders the page if input is invalid" do
        post :create, params: {business: Fabricate.attributes_for(:business, name: "")}
        expect(response).to render_template 'new'
      end
      it "saves the newly created business" do
        count = Business.count
        post :create, params: {business: Fabricate.attributes_for(:business)}
        expect(Business.count).to eq(count + 1)
      end
      it "does not save a business if invalid" do
        count = Business.count
        post :create, params: {business: Fabricate.attributes_for(:business, name: "")}
        expect(Business.count).to eq(count)
      end
      it "only requires a name" do
        count = Business.count
        post :create, params: {business: Fabricate.attributes_for(:business, phone_number: "", address: "")}
        expect(Business.count).to eq(count + 1)
      end
    end

    context "with non-logged in user" do
      it "redirects to the login page" do
        post :create, params: {business: Fabricate.attributes_for(:business)}
        expect(response).to redirect_to login_path
      end
      it "doesn't save the business" do
        count = Business.count
        post :create, params: {business: Fabricate.attributes_for(:business)}
        expect(Business.count).to eq(count)
      end
    end
  end

  describe 'GET show' do
    it "creates the @business variable" do
      biz = Fabricate(:business)
      get :show, params: {id: biz.id}
      expect(assigns(:business).id).to eq(biz.id)
    end
    it "has a @review variable" do
      biz = Fabricate(:business)
      get :show, params: {id: biz.id}
      expect(assigns(:review)).to_not be_nil
    end
  end
end