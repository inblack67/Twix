defmodule Twix.Repo.PostRepo do
  import Ecto.Query, only: [from: 2]

  alias Twix.Repo
  alias Twix.Feed.Post
  alias Twix.Repo.UserRepo

  def get_posts() do
    Repo.all(from(p in Post, order_by: [desc: p.inserted_at]))
    |> Repo.preload(:user)
  end

  def create_post(user_id, %{"content" => content, "title" => title}) do
    user = UserRepo.get_user_by_id!(user_id)

    post_with_user =
      user
      |> Ecto.build_assoc(
        :posts,
        _id: UUID.uuid4(),
        content: content,
        title: title
      )

    {:ok, post} =
      Post.changeset(post_with_user, %{})
      |> Repo.insert()

    preloaded_post =
      post
      |> Repo.preload(:user)

    {:ok, preloaded_post}
  end

  def delete_post(post_id, user_id) do
    from(p in Post,
      where:
        p.id == ^post_id and
          p.user_id == ^user_id
    )
    |> Repo.delete_all()
  end
end
