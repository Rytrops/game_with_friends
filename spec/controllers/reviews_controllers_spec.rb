require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  describe "GET #index" do
    let(:review) { Review.create(title: "toot toot", body: "great game")}
    it "returns the proper view" do
      get :index
      # expect(response).to be_success
      expect(response).to render_template(:index)
      expect(assigns(:reviews)).to eq([review])
    end
  end

end
