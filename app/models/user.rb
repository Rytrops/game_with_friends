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
    if !steam_url.nil?
      vanity_or_steamID_url
    end
    if !(self.steam_url.nil?) && self.steam_id.nil?
      if valid_steamID?
        self.steam_id = extrapolate_steamID
      else
        errors.add(:steam_url, "Must be proper format")
      end
    end
  end
  
  def vanity_or_steamID_url
    parsed_steam_url = self.steam_url.split('/')
    if parsed_steam_url[3] == 'id'
      extrapolate_steam_vanity
    elsif parsed_steam_url[3] == 'profile'
      extrapolate_steamID
    end
  end
    
  def extrapolate_steamID
    self.steam_id = parse_steam_url[4]
  end

  def extrapolate_steam_vanity
    self.steam_vanity = parse_steam_url[4]
    convert_steam_vanity_to_steamID
  end

  def convert_steam_vanity_to_steamID
    Steam.apikey = ENV["STEAM_API_KEY"]
    self.steam_id = Steam::User.vanity_to_steamid(self.steam_vanity)
  end

  def valid_steamID?
    Steam.apikey = ENV["STEAM_API_KEY"]
    !Steam::User.summary(extrapolate_steamID).nil?
  end

end
