# The first thing you need to configure is which modules you need in your app.
# The default is nothing which will include only core features (password encryption, login/logout).
# Available submodules are: :user_activation, :http_basic_auth, :remember_me,
# :reset_password, :session_timeout, :brute_force_protection, :activity_logging, :external
Rails.application.config.sorcery.submodules = [:external]

# Here you can configure each submodule's features.
Rails.application.config.sorcery.configure do |config|

  config.external_providers = [:twitter]

  config.twitter.key = "L8qq9PZyRg6ieKGEKhZolGC0vJWLw8iEJ88DRdyOg"
  config.twitter.secret = "L8qq9PZyRg6ieKGEKhZolGC0vJWLw8iEJ88DRdyOg"
  config.twitter.callback_url = "http://0.0.0.0:3000/oauth/callback?provider=twitter"
  config.twitter.user_info_mapping = {:username => "screen_name"}

  config.user_config do |user|
    user.authentications_class = Authentication
  end

  config.user_class = "User"
end
