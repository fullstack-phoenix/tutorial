# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :tutorial, ecto_repos: [Tutorial.Repo], generators: [binary_id: true]

# Configures the endpoint
config :tutorial, TutorialWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "gezCztOVJKD3K7/pRxOCsVz2/26KpvIXP6iwcLAtR6kikK55jKMTPDbjxLrheGDc",
  render_errors: [view: TutorialWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Tutorial.PubSub,
  live_view: [signing_salt: "ywIHqVZp"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# POW Configuration
config :tutorial, :pow,
  user: Tutorial.Users.User,
  repo: Tutorial.Repo,
  extensions: [PowResetPassword, PowEmailConfirmation],
  controller_callbacks: Pow.Extension.Phoenix.ControllerCallbacks,
  web_module: TutorialWeb,
  mailer_backend: TutorialWeb.Pow.Mailer

config :tutorial, Tutorial.Mailer,
  adapter: Bamboo.MandrillAdapter,
  api_key: "my_api_key"

config :kaffy,
   otp_app: :tutorial,
   ecto_repo: Tutorial.Repo,
   router: TutorialWeb.Router

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
