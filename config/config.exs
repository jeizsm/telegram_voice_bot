# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :telegram_bot, TelegramBot.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: TelegramBot.ErrorView, accepts: ~w(json)],
  secret_key_base: "2k23OJbb5DyPIOE/sMrz3jXfH1m4mwueMPoGnkw88tN8uoYPg8CK9tkL9nD7Ueht"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :nadia, token: System.get_env("TELEGRAM_TOKEN")
config :goth,
  json: {:system, "GCP_CREDENTIALS"}
config :goth, scope: "https://www.googleapis.com/auth/cloud-platform"
config :goth, url: "https://speech.googleapis.com/v1beta1/speech:syncrecognize"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
