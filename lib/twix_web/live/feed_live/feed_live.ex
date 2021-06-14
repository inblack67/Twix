defmodule TwixWeb.FeedLive do
  use TwixWeb, :live_view

  alias Twix.Feed.Post
  alias Twix.Repo.PostRepo

  @impl true
  def mount(_params, %{"current_user_id" => current_user_id}, socket) do
    new_socket =
      socket
      |> assign(%{changeset: Post.changeset(%Post{}, %{})})
      |> assign(%{current_user_id: current_user_id})

    {:ok, new_socket}
  end

  @impl true
  def mount(_params, _session, socket) do
    {:error, socket}
  end

  # @impl true
  # def handle_event("validate", %{"post" => post}, socket) do
  #   IO.inspect(socket)

  #   changeset =
  #     socket.assign.post
  #     |> PostRepo.validate_post(post)

  #   {:noreply, assign(socket, changeset: changeset)}
  # end

  @impl true
  def handle_event("save", %{"post" => post}, socket) do
    IO.inspect(socket)

    ready_post =
      post
      |> Map.put("user_id", socket.assigns.current_user_id)

    case PostRepo.create_post(ready_post) do
      {:ok, _post} -> put_flash(socket, :info, "Post created")
      {:error, changeset} -> assign(socket, changeset: changeset)
    end

    {:noreply, socket}
  end
end
