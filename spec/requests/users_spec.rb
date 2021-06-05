require 'rails_helper'
describe "Users", type: :request do
  describe 'GET /users' do
    it "returns all users" do
      FactoryBot.create(:user, username: '123456', password:'123456', email: '123@test.com')
      get '/api/v1/users'
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(1)
    end
  end
end
