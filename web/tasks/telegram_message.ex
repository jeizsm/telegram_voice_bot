defmodule TelegramBot.TelegramMessage do
  @moduledoc false

  import TelegramBot.Helper, only: [deep_atomize: 1]
  alias TelegramBot.VoiceRecognition
  alias Nadia

  def parse(message) do
    parsed_message = message |> deep_atomize |> List.wrap |>
      Parser.parse_result("getUpdates") |> hd
    reply(parsed_message)
  end

  defp reply(%{message: %{text: "/start", chat: %{id: chat_id}}}) do
    %{method: "sendMessage", chat_id: chat_id, text: "Дратути"}
  end

  defp reply(%{message: %{chat: %{id: chat_id}, voice: voice}}) do
    VoiceRecognition.start_child(voice, chat_id)
    %{success: true}
  end

  defp reply(%{}) do
    %{success: true}
  end
end
