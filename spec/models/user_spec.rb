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

  describe 'correct_steam_url_validations' do

    context 'proper steam_url' do
      let(:valid_user){User.new(username: 'test user', email: 'Email@email.com', password: '123456', steam_url: 'https://steamcommunity.com/profiles/76561198068892037/')}
      before :each do
        allow(valid_user).to receive(:valid_steamID?).and_return true
      end

      it 'should be able to save if a proper id url is given' do
        expect(valid_user.save).to be(true)
      end

      
      it 'should be able to save if a proper vanity url is given' do
        valid_user.steam_url = 'https://steamcommunity.com/profiles/123456/'
        expect(valid_user.save).to be(true)
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

      it 'should not update the steamID if given a new steam_url when it has a url already' do
        allow(valid_user).to receive(:valid_steamID?).and_return true
        valid_user.save
        valid_user.steam_url = 'https://steamcommunity.com/profiles/123456/'
        valid_user.save
        expect(valid_user.steam_id).to eq('76561198068892037')
      end

      it 'should update the steam_vanity if given a vanity steam url' do
        valid_user.steam_url = 'https://steamcommunity.com/id/FifthSurprise/'
        valid_user.save
        expect(valid_user.steam_vanity).to eq('FifthSurprise')
      end

      it 'should update the steam_id if given a vanity steam url' do
        valid_user.steam_url = 'https://steamcommunity.com/id/FifthSurprise/'
        valid_user.save
        
        expect(valid_user.steam_id).to eq('76561197985548237')
      end

      it 'should not update the steam_vanity if given a vanity steam url while already having a steam vanity id' do
        valid_user.steam_vanity = 'SampleName'
        valid_user.save
        valid_user.steam_url = 'https://steamcommunity.com/id/FifthSurprise/'
        valid_user.save
        expect(valid_user.steam_vanity).to eq('SampleName')
      end
    end

    context 'improper steam URL' do
      let(:invalid_user){User.new(username: 'test user', email: 'Email@email.com', password: '123456', steam_url: 'https://steamcommunity.com/profiles/737/')}
      before :each do
        allow(invalid_user).to receive(:valid_steamID?).and_return false
      end

      it 'should raise an error if invalid steam url' do
        invalid_user.save
        expect(invalid_user.errors.errors.length).to eq(1)
      end


      it 'should raise an error if invalid steam url' do
        invalid_user.save
        expect(invalid_user.errors.errors.first.type).to eq("Invalid Steam Profile URL")
      end

      it 'should raise an error if invalid steam url v2' do
        begin
          invalid_user.save!
        rescue => error 
        end
        expect(error.message).to eq("Validation failed: Steam url Invalid Steam Profile URL")
      end

      it 'should raise an error if a non steam URL is given' do
        invalid_user.steam_url = 'BadURL.com'
        begin
          invalid_user.save!
        rescue => error
        end
        expect(error.message).to eq("Validation failed: Steam url Invalid Steam Profile URL")
      end

      it 'should not save if an improper id url is given' do
        expect(invalid_user.save).to be(false)
      end
   
      it 'should not save if an improper vanity url is given' do
        invalid_user.steam_url = 'https://steamcommunity.com/profiles/dqwd654as28/'
        expect(invalid_user.save).to be(false)
      end

    end
  end
end

