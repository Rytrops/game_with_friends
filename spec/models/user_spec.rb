require 'rails_helper'
require 'pry'

RSpec.describe User, type: :model do
  
  context 'validation tests' do
    it 'ensures username is present to save' do
      user = User.new(email: 'Email@email.com')
      expect(user.save).to eq(false)
    end

    it 'ensures email is present to save' do
      user = User.new(username: 'test user')
      expect(user.save).to eq(false)
    end

    it 'should save succesfully' do
      user = User.new(username: 'test user', email: 'Email@email.com', password: '123456')
      expect(user.save).to eq(true)
    end

  end

  context '#update_steamID' do
    let(:valid_user){User.new(username: 'test user', email: 'Email@email.com', password: '123456', steam_url: 'https://steamcommunity.com/profiles/76561198068892037/')}
    let(:invalid_user){User.new(username: 'test user', email: 'Email@email.com', password: '123456', steam_url: 'https://steamcommunity.com/profiles/737/')}
    before :each do
      allow(valid_user).to receive(:valid_steamID?).and_return true
      allow(invalid_user).to receive(:valid_steamID?).and_return false
    end
    it 'should update the steamID if nil and if given a new steam_url' do
      valid_user.save
      expect(valid_user.steam_id).to eq('76561198068892037')
    end

    it 'should not update the steamID if a steamID already exists and if given a new steam_url' do
      valid_user.steam_id = '123456'
      valid_user.save
      expect(valid_user.steam_id).to eq('123456')
    end

    it 'should not update the steamID if given a new steam_url when it has one already' do
      allow(valid_user).to receive(:valid_steamID?).and_return true
      valid_user.save
      valid_user.steam_url = 'https://steamcommunity.com/profiles/123456/'
      valid_user.save
      expect(valid_user.steam_id).to eq('76561198068892037')
    end

    it 'should raise an error if invalid steam url' do
      invalid_user.save
      expect(invalid_user.errors.errors.length).to eq(1)
    end

    it 'should raise an error if invalid steam url' do
      invalid_user.save
      expect(invalid_user.errors.errors.first.type).to eq("Must be proper format")
    end

    it 'should raise an error if invalid steam url v2' do
      user = User.new(username: 'test user', email: 'Email@email.com', password: '123456', steam_url: 'https://steamcommunity.com/profiles/737/')
      begin
        user.save!
      rescue => error 
      end
      expect(error.message).to eq("Validation failed: Steam url Must be proper format")
    end
  end

end
