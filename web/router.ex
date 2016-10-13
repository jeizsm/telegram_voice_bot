defmodule TelegramBot.Router do
  @moduledoc false

  use TelegramBot.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/telegram", TelegramBot do
    pipe_through :api

    post "/:token", PageController, :reply
  end
end
