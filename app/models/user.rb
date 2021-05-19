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
  validate :correct_steam_url, on: :update
  

  private 

  def correct_steam_url
    if !(self.steam_url.nil?) && self.steam_id.nil?
      if valid_steamID?
        self.steam_id = extrapolate_steamID
      else
        errors.add(:steam_url, "Must be proper format")
      end
    end
  end
  # def update_steamID

  #   if !(self.steam_url.nil?) && self.steam_id.nil?
  #     if valid_steamID?
  #       self.steam_id = extrapolate_steamID
  #     else
  #       # raise 'Steam ID was not valid'
  #       # ActiveRecord::
  #       raise StandardError.new('Steam ID was not valid')
  #     end
  #   end
  # end
  def extrapolate_steamID
      # I use the 4 index because thats where the id occurs, this assumes my user is acting in good faith and doesnt supply the wrong link. Should make thise more robust later.
      steam_id = self.steam_url.split("/")[4]
  end

  def valid_steamID?
    Steam.apikey = ENV["STEAM_API_KEY"]
    !Steam::User.summary(extrapolate_steamID).nil?
  end

end
