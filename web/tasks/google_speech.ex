defmodule TelegramBot.GoogleSpeech do
  @moduledoc false

  alias Goth.Token

  def voice_recognize(file, %{enc: enc, rate: rate, lang: lang}) do
    scope = Application.fetch_env!(:goth, :scope)
    url = Application.fetch_env!(:goth, :url)
    json = %{
      audio: %{content: file |> Base.encode64},
      config: %{encoding: enc, sampleRate: rate, languageCode: lang}
    } |> Poison.encode!

    with {:ok, token} = Token.for_scope(scope),
         headers = [{"Content-Type", "application/json"},
                    {"Authorization", "#{token.type} #{token.token}"}],
         {:ok, %{body: body}} = HTTPoison.post(url, json, headers),
         {:ok, %{"results" => results}} = Poison.decode(body),
      do: results
  end

  def text(results) do
    Enum.map_join(results, " ", &get_transcript/1)
  end

  defp get_transcript(result) do
    result |> Map.get("alternatives") |> hd |> Map.get("transcript")
  end
end
