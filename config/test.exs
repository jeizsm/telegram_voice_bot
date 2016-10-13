use Mix.Config

config :telegram_bot, TelegramBot.Endpoint,
  http: [port: 4001],
  server: false

config :logger, level: :warn
