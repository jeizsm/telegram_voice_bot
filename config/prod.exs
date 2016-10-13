use Mix.Config

config :telegram_bot, TelegramBot.Endpoint,
  http: [port: {:system, "PORT"}]

config :telegram_bot, TelegramBot.Endpoint,
  secret_key_base: System.get_env("SECRET_KEY_BASE")

config :logger, level: :info
