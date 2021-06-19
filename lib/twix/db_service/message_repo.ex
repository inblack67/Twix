defmodule Twix.Repo.MessageRepo do
  import Ecto.Query, only: [from: 2]

  alias Twix.Repo
  alias Twix.Chat.Message

  def get_messages(limit \\ 20) do
    Repo.all(from(m in Message, limit: ^limit))
  end
end
