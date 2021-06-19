require 'dotenv/load'
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :users_videogames
  has_many :videogames, through: :users_videogames

  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :steam_url,  uniqueness: { case_sensitive: false }, allow_blank: true
  validate :correct_steam_url

  def import_steam_library
    if steam_url.nil?
      steam_url_error_message
      return false
    else
      Steam.apikey = ENV["STEAM_API_KEY"]
      imported_games =  Steam::Player.owned_games(steam_id, params: {include_appinfo: 1})
      imported_games["games"].each do |game|
        videogame = Videogame.find_by(game_name: game["name"])
        if videogame.nil?
          new_game = Videogame.new(game_name: game["name"])
          if new_game.save
            self.videogames << new_game
          end
        elsif self.videogames.find_by(game_name: game["name"]).nil?
          self.videogames << videogame
        end
      end
    end

  end
  

  private 

  def correct_steam_url
    if !(self.steam_url.nil?) && self.steam_id.nil? && self.steam_vanity.nil?
      if vanity_url?
        begin
        extrapolate_steam_vanity
        convert_steam_vanity_to_steamID
        rescue Steam::SteamError 
        end
        steam_url_error_message unless valid_steamID?
      elsif id_url?
        extrapolate_steamID
        steam_url_error_message unless valid_steamID?
      else
        steam_url_error_message
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
    Steam.apikey = ENV["STEAM_API_KEY"]
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

  def steam_url_error_message
    errors.add(:steam_url, 'Invalid steam profile URL')
  end

end
