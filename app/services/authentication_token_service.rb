require 'dotenv/load'
class AuthenticationTokenService
  ALGORITHM_TYPE = 'HS256'

  def self.encode_token(user)
    payload = { 'user_id' => "#{user.id}", 'username' => "#{user.username}"}
    JWT.encode payload, ENV['HMAC_SECRET'], ALGORITHM_TYPE
  end

  def self.decode_token(token)
    decoded_token = JWT.decode token, ENV['HMAC_SECRET'], true, {algorithm: ALGORITHM_TYPE}
    decoded_token[0]['user_id']
  end

end
