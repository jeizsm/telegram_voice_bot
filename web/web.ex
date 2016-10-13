defmodule TelegramBot.Web do
  @moduledoc false

  def model do
    quote do
    end
  end

  def controller do
    quote do
      use Phoenix.Controller
    end
  end

  def view do
    quote do
    end
  end

  def router do
    quote do
      use Phoenix.Router
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
