require 'rails_helper'

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
    it 'should update the steamID if nil and if given a new steam_url' do
      user = User.new(username: 'test user', email: 'Email@email.com', password: '123456', steam_url: 'https://steamcommunity.com/profiles/76561198068892037/')
      user.save
      expect(user.steam_id).to eq('76561198068892037')
    end

    it 'should not update the steamID if a steamID already exists and if given a new steam_url' do
      user = User.new(username: 'test user', email: 'Email@email.com', password: '123456', steam_url: 'https://steamcommunity.com/profiles/76561198068892037/',steam_id: '123456')
      user.save
      expect(user.steam_id).to eq('123456')
    end

    it 'should not update the steamID if given a new steam_url when it has one already' do
      user = User.new(username: 'test user', email: 'Email@email.com', password: '123456', steam_url: 'https://steamcommunity.com/profiles/76561198068892037/')
      user.save
      user.steam_url = 'https://steamcommunity.com/profiles/123456/'
      user.save
      expect(user.steam_id).to eq('76561198068892037')
    end
  end

end
