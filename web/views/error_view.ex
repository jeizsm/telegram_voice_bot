defmodule TelegramBot.ErrorView do
  @moduledoc false

  use TelegramBot.Web, :view

  def render("500.json", _params) do
    %{success: false}
  end

  def render("404.json", _params) do
    %{success: false}
  end
end
