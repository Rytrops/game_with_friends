require 'dotenv/load'
class AuthenticationTokenService
  ALGORITHM_TYPE = 'HS256'

  def self.encode_token(user)
    payload = { 'user_id' => "#{user.id}", 'username' => "#{user.username}"}
    JWT.encode payload, ENV["HMAC_SECRET"], ALGORITHM_TYPE
  end

end
