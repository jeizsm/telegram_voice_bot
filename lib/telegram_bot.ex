defmodule TelegramBot do
  @moduledoc false

  use Application
  alias TelegramBot.Endpoint

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(Task.Supervisor, [[name: TelegramBot.TelegramMessageSupervisor,
                                    restart: :transient]]),
      supervisor(TelegramBot.Endpoint, []),
    ]

    opts = [strategy: :one_for_one, name: TelegramBot.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    Endpoint.config_change(changed, removed)
    :ok
  end
end
