defmodule TwixWeb.FeedLive.Create do
  use TwixWeb, :live_view

  alias Twix.Feed.Post
  alias Twix.Repo.PostRepo

  @feed_topic "feed_topic"
  @new_post "new_post"

  @impl true
  def mount(_params, %{"current_user_id" => current_user_id}, socket) do
    changeset = Post.changeset(%Post{}, %{})

    {:ok,
     socket
     |> assign(:post, %Post{})
     |> assign(:changeset, changeset)
     |> assign(:current_user_id, current_user_id)}
  end

  @impl true
  def handle_event("validate", %{"post" => post_input}, socket) do
    changeset =
      socket.assigns.post
      |> Post.changeset(post_input)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  @impl true
  def handle_event("save", %{"post" => post_input}, socket) do
    case PostRepo.create_post(socket.assigns.current_user_id, post_input) do
      {:ok, post} ->
        TwixWeb.Endpoint.broadcast(@feed_topic, @new_post, post)

        {:noreply,
         socket
         |> put_flash(:info, "Post created successfully")
         |> push_redirect(to: Routes.feed_path(socket, :index))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
