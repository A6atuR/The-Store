require 'controllers/controllers_spec_helper'

describe CategoriesController do
  before do
    @customer = create(:customer)
    @category = create(:category) 
    redefine_cancan_abilities
  end

  context "GET #index" do
    context 'being signed in' do
      before do
        sign_in @customer
        get :index
      end

      it "responds successfully with an HTTP 200 status code" do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it "renders the index template" do
        expect(response).to render_template("index")
      end
    end

    context 'being not signed in' do
      before do
        get :index
      end

      it { should redirect_to new_customer_session_path }
    end

    context 'cancan doesnt allow :index' do
      before do
        sign_in @customer
        @ability.cannot :index, Category
        get :index
      end

      it { should redirect_to root_path }
    end
  end

  context "GET #show" do
    context 'being signed in' do
      before do
        sign_in @customer
        get :show, id: @category.id 
      end

      it "responds successfully with an HTTP 200 status code" do 
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it "renders the #show view" do 
        response.should render_template :show 
      end
    end

    context 'being not signed in' do
      before do
        get :show, id: @category.id 
      end

      it { should redirect_to new_customer_session_path }
    end

    context 'cancan doesnt allow :show' do
      before do
        sign_in @customer
        @ability.cannot :show, Category
        get :show, id: @category.id 
      end

      it { should redirect_to root_path }
    end
  end
end