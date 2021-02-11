require 'rails_helper'

RSpec.describe User, type: :model do
  
  context "validation tests" do
    it "ensures username is present to save" do
      user = User.new(email_address: "Email@email.com")
      expect(user.save).to eq(false)
    end

    it "ensures email is present to save" do
      user = User.new(username: "test user")
      expect(user.save).to eq(false)
    end

    it "should save succesfully" do
      user = User.new(username: "test useR", email_address: "Email@email.com")
      expect(user.save).to eq(true)
    end

  end

end
