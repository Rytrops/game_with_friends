require 'rails_helper'
AUTHORIZATION = ''

describe "Users", type: :request do
  describe 'GET /users' do
  end
    

  it "returns all users" do
    
    user = User.new(username: '1234567', password: '123456', email: '123@test.com')
    user.save
    debugger
    get '/api/v1/users', headers: {'Authorization' => AUTHORIZATION}
    expect(JSON.parse(response.body).length).to be(1)
  end
end
