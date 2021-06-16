defmodule Twix.Repo.PostRepo do
  alias Twix.Repo
  alias Twix.Feed.Post

  def get_posts() do
    Repo.all(Post)
  end

  def create_post(input) do
    Post.changeset(%Post{}, input)
    |> Repo.insert()
  end
end
