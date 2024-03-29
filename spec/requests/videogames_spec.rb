 require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/videogames", type: :request do
  # Videogame. As you add validations to Videogame, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET /index" do
    it "renders a successful response" do
      Videogame.create! valid_attributes
      get videogames_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      videogame = Videogame.create! valid_attributes
      get videogame_url(videogame)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_videogame_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      videogame = Videogame.create! valid_attributes
      get edit_videogame_url(videogame)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Videogame" do
        expect {
          post videogames_url, params: { videogame: valid_attributes }
        }.to change(Videogame, :count).by(1)
      end

      it "redirects to the created videogame" do
        post videogames_url, params: { videogame: valid_attributes }
        expect(response).to redirect_to(videogame_url(Videogame.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Videogame" do
        expect {
          post videogames_url, params: { videogame: invalid_attributes }
        }.to change(Videogame, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post videogames_url, params: { videogame: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested videogame" do
        videogame = Videogame.create! valid_attributes
        patch videogame_url(videogame), params: { videogame: new_attributes }
        videogame.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the videogame" do
        videogame = Videogame.create! valid_attributes
        patch videogame_url(videogame), params: { videogame: new_attributes }
        videogame.reload
        expect(response).to redirect_to(videogame_url(videogame))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        videogame = Videogame.create! valid_attributes
        patch videogame_url(videogame), params: { videogame: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested videogame" do
      videogame = Videogame.create! valid_attributes
      expect {
        delete videogame_url(videogame)
      }.to change(Videogame, :count).by(-1)
    end

    it "redirects to the videogames list" do
      videogame = Videogame.create! valid_attributes
      delete videogame_url(videogame)
      expect(response).to redirect_to(videogames_url)
    end
  end
end
