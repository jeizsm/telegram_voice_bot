defmodule TelegramBot.PageController do
  @moduledoc false

  use TelegramBot.Web, :controller
  alias Phoenix.Router.NoRouteError
  alias TelegramBot.TelegramMessage

  def reply(conn, %{"token" => token} = params) do
    json = case Application.fetch_env!(:nadia, :token) == token do
      true -> TelegramMessage.parse(params)
      false -> raise %NoRouteError{conn: conn, router: TelegramBot.Router}
    end
    render conn, "index.json", %{json: json}
  end
end
