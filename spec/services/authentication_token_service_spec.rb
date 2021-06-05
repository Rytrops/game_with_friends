require 'rails_helper'
require 'dotenv/load'

describe AuthenticationTokenService do
  describe '.encode_token'do
  let(:token) {described_class.encode_token}
    it 'returns an authentication token' do
      decoded_token = JWT.decode token, ENV["HMAC_SECRET"], true, { algorithm: 'HS256' }
      expect(decoded_token).to eq(
        [
          {'test' => 'block'},
          {'alg' => 'HS256'}
        ]
      )
    end
  end
end