defmodule Twix.Repo.PostRepo do
  import Ecto.Query, only: [from: 2]

  alias Twix.Repo
  alias Twix.Feed.Post
  alias Twix.Repo.UserRepo

  def get_posts() do
    Repo.all(from(p in Post, order_by: [desc: p.inserted_at]))
  end

  def create_post(user_id, input) do
    user = UserRepo.get_user_by_id!(user_id)
    IO.inspect(user)
    input_with_uuid = Map.put(input, "_id", UUID.uuid4())

    post_with_user =
      user
      |> Ecto.build_assoc(:user, input_with_uuid)

    IO.inspect(post_with_user)

    Post.changeset(%Post{}, post_with_user)
    |> Repo.insert()
  end
end
