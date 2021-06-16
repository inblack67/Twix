defmodule Twix.Repo.PostRepo do
  import Ecto.Query, only: [from: 2]

  alias Twix.Repo
  alias Twix.Feed.Post

  def get_posts() do
    Repo.all(from(p in Post, order_by: [desc: p.inserted_at]))
  end

  def create_post(input) do
    Post.changeset(%Post{}, input)
    |> Repo.insert()
  end
end
