defprotocol TelegramBot.Downloadable do
  def download(model)
end

defimpl TelegramBot.Downloadable, for: Nadia.Model.Voice do
  def download(%{file_id: file_id}) do
    with {:ok, file} = Nadia.get_file(file_id),
         {:ok, url} = Nadia.get_file_link(file),
         {:ok, %{body: body}} = HTTPoison.get(url),
      do: body
  end
end
