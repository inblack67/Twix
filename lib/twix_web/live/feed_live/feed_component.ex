defmodule TwixWeb.FeedLive.FeedComponent do
  use TwixWeb, :live_component
  alias Twix.Feed.Post

  def handle_event("on_change", params, _socket) do
    IO.puts("on_change event")
    IO.inspect(params)
    changeset = Post.changeset(%Post{}, %{})
    {:noreply, changeset: changeset}
  end

  def handle_event("save", params, _socket) do
    IO.puts("save event")
    IO.inspect(params)
  end

  def update(%{post: post} = assigns, socket) do
    changeset = Post.changeset(post, %{})

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end
end
