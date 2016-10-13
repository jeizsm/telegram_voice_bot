defmodule TelegramBot.Helper do
  @moduledoc false

  def deep_atomize(map) do
    deep_atomize_p(map)
  end

  defp deep_atomize_p(%{} = map) do
    for {key, value} <- map, into: %{} do
      {String.to_atom(key), deep_atomize(value)}
    end
  end

  defp deep_atomize_p(value), do: value
end
