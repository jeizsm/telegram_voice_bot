defmodule TelegramBot.PageView do
  @moduledoc false

  use TelegramBot.Web, :view

  def render("index.json", %{json: json}) do
    json
  end
end
