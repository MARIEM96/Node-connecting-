defmodule Chatting.Application do
  @moduledoc false

    use Application

    def start(_type, _args) do
      children = [
        {Task.Supervisor, name: Chatting.TaskSupervisor}
      ]

      opts = [strategy: :one_for_one, name: Chatting.Supervisor]
      Supervisor.start_link(children, opts)
    end
  end
