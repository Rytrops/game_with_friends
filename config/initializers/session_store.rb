if Rails.env === 'production' 
  Rails.application.config.session_store :cookie_store, key: '_game_with_Friends', domain: 'name-of-you-app-json-api'
else
  Rails.application.config.session_store :cookie_store, key: '_game_with_Friends'
end