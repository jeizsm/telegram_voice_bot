defmodule TelegramBot.Endpoint do
  @moduledoc false

  use Phoenix.Endpoint, otp_app: :telegram_bot

  if code_reloading? do
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug TelegramBot.Router
end
