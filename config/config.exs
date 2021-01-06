# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :hotwire_phoenix_demo_chat,
  ecto_repos: [HotwirePhoenixDemoChat.Repo]

# Configures the endpoint
config :hotwire_phoenix_demo_chat, HotwirePhoenixDemoChatWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "mtgBKWprtmOI+mIYv8ArTvNC17e0QGM65//ctXl3p8K6qYu/vdZKbLb88sELaVX+",
  render_errors: [view: HotwirePhoenixDemoChatWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: HotwirePhoenixDemoChat.PubSub,
  live_view: [signing_salt: "tGEzVzpI"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
