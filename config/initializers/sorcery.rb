Rails.application.config.sorcery.submodules = [:external]

# Here you can configure each submodule's features.
Rails.application.config.sorcery.configure do |config|

  config.external_providers = [:twitter]


  puts 1
  p Rails.application.secrets.twitter_callback_url

  config.twitter.key = Rails.application.secrets.twitter_key
  config.twitter.secret = Rails.application.secrets.twitter_secret
  config.twitter.callback_url = Rails.application.secrets.twitter_callback_url
  config.twitter.user_info_mapping = {username: "screen_name"}

  config.user_config do |user|
    user.authentications_class = Authentication
  end

  config.user_class = "User"
end
