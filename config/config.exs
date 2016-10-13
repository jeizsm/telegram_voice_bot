use Mix.Config

config :telegram_bot, TelegramBot.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: TelegramBot.ErrorView, accepts: ~w(json)],
  secret_key_base: "2k23OJbb5DyPIOE/sMrz3jXfH1m4mwueMPoGnkw88tN8uoYPg8CK9tkL9nD7Ueht"

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :nadia, token: System.get_env("TELEGRAM_TOKEN")

config :goth,
  json: {:system, "GCP_CREDENTIALS"}
config :goth, scope: "https://www.googleapis.com/auth/cloud-platform"
config :goth, url: "https://speech.googleapis.com/v1beta1/speech:syncrecognize"

import_config "#{Mix.env}.exs"
