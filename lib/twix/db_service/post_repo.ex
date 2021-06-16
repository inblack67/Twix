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

  def validate_post(post, attrs \\ %{}) do
    Post.changeset(post, attrs)
  end

  def post_changeset(%Post{} = post, attrs \\ %{}) do
    Post.changeset(post, attrs)
  end
end
