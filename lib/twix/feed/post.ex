defmodule Twix.Feed.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :title, :string
    field :content, :string
    field :likes, :integer, default: 0
    field :image_urls, {:array, :string}, default: []
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :content, :likes, :image_urls, :user_id])
    |> validate_required([:title, :content])
    |> validate_length(:title, min: 5, max: 30)
    |> validate_length(:content, min: 10, max: 300)
    |> unique_constraint(:title)
  end
end
