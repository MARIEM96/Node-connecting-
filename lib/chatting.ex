defmodule Chatting do
  use GenServer
  def start_link() do
    GenServer.start_link(__MODULE__, [], name: :chat)
  end
  def recevoir(message) do
    IO.puts(message)
  end



  def init( message_vide) do
    {:ok, message_vide}
  end

  def send_message( noeud, message) do
    GenServer.cast(:chat,{:send, noeud, message})

  end
   def handle_cast({:send, noeud, message}, state) do


    {:noreply, [send(__MODULE__, :recevoir, noeud, [message])|state] }

   end
  def send(module, fun, destinataire, args) do
    destinataire |> supervisor() |> Task.Supervisor.async(module, fun, args) |> Task.await()
  end

  defp supervisor(destinataire) do
    {Chatting.TaskSupervisor, destinataire}
  end
end
