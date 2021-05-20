require 'dotenv/load'
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :users_videogames
  has_many :videogames, through: :users_videogames

  validates :username, presence: true
  validates :email, presence: true
  validate :correct_steam_url
  

  private 

  def correct_steam_url
    if !(self.steam_url.nil?) && self.steam_id.nil? && self.steam_vanity.nil?
      if vanity_url?
        extrapolate_steam_vanity
          if valid_steamID? 
            convert_steam_vanity_to_steamID
            errors.add(:steam_url, 'Must be proper format') unless valid_steamID?
          end
      elsif id_url?
        if valid_steamID?
          extrapolate_steamID
        else
          errors.add(:steam_url, 'Must be proper format')
        end
      end
    end
  end

  def parsed_steam_url
    parsed_steam_url = self.steam_url.split('/')
  end

  def vanity_url?
    parsed_steam_url[3] == 'id'
  end

  def id_url?
    parsed_steam_url[3] == 'profiles'
  end

  def extrapolate_steamID
    self.steam_id = parsed_steam_url[4]
  end

  def extrapolate_steam_vanity
    self.steam_vanity = parsed_steam_url[4]
  end

  def convert_steam_vanity_to_steamID
    Steam.apikey = ENV["STEAM_API_KEY"]
    self.steam_id = Steam::User.vanity_to_steamid(self.steam_vanity)
  end

  def valid_steamID?
    Steam.apikey = ENV["STEAM_API_KEY"]
    !Steam::User.summary(self.steam_id).nil?
  end

end
