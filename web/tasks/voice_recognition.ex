defmodule TelegramBot.VoiceRecognition do
  @moduledoc false

  @rate 16_000

  alias TelegramBot.TelegramMessageSupervisor, as: Supervisor
  alias TelegramBot.Downloadable

  def start_child(voice, chat_id) do
    Task.Supervisor.start_child(Supervisor, __MODULE__, :download_and_recognize,
      [voice, chat_id])
  end

  def download_and_recognize(voice, chat_id) do
    audio = get_flac(voice)
    Task.Supervisor.start_child(Supervisor, __MODULE__, :recognize_and_reply,
      [audio, chat_id])
  end

  def recognize_and_reply(audio, chat_id) do
    text = recognize(audio)
    Task.Supervisor.start_child(Supervisor, __MODULE__, :reply, [text, chat_id])
  end

  def reply(text, chat_id) do
    {:ok, _} = Nadia.send_message(chat_id, text, [disable_notification: true])
  end

  defp get_flac(voice) do
    with {:ok, _} = Temp.track,
         {:ok, ogg} = Temp.path(%{suffix: ".ogg"}),
         {:ok, flac} = Temp.path(%{suffix: ".flac"}),
         :ok = File.write(ogg, Downloadable.download(voice)),
         :ok = convert_ogg_to_flac(ogg, flac),
      do: flac |> File.read!
  end

  defp recognize(audio) do
    import TelegramBot.GoogleSpeech
    options = %{enc: "FLAC", rate: 16_000, lang: "ru-RU"}
    audio |> voice_recognize(options) |> text
  end

  defp convert_ogg_to_flac(ogg, flac) do
    import FFmpex
    use FFmpex.Options

    FFmpex.new_command |>
      add_global_option(option_y) |>
      add_input_file(ogg) |>
      add_output_file(flac) |>
      add_file_option(option_ar(@rate)) |>
      execute
  end
end
