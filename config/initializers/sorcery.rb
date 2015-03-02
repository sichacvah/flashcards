Rails.application.config.sorcery.submodules = [:external]

# Here you can configure each submodule's features.
Rails.application.config.sorcery.configure do |config|
  config.external_providers = [:twitter]

  config.twitter.key = Rails.application.secrets.twitter_key
  config.twitter.secret = Rails.application.secrets.twitter_secret
  config.twitter.callback_url = Rails.application.secrets.twitter_callback_url
  config.twitter.user_info_mapping = { email: "screen_name" }

  config.user_class = "User"
  config.user_config do |user|
    user.username_attribute_names = [:email]
    user.authentications_class = Authentication
  end
end
