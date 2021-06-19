defmodule Twix.Repo.MessageRepo do
  import Ecto.Query, only: [from: 2]

  alias Twix.Repo
  alias Twix.Chat.Message

  def get_messages(limit \\ 20) do
    Repo.all(from(m in Message, limit: ^limit))
  end

  def create_message(message, room_id, user_id) do
    IO.inspect(message)
    IO.inspect(room_id)
    IO.inspect(user_id)
    
    {:ok, %Message{}}
  end
end
