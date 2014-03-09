require 'spec_helper'

describe CategoriesController do
  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET #show" do
    it "responds successfully with an HTTP 200 status code" do
      get :show, id: create(:category) 
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "renders the #show view" do 
      get :show, id: create(:category) 
      response.should render_template :show 
    end
  end
end