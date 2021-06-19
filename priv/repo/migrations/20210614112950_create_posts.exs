defmodule Twix.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :content, :string, null: false
      add :title, :string, null: false
      add :image_urls, {:array, :string}, null: false, default: []
      add :user_id, references(:users, on_delete: :delete_all)
      add :_id, :string, null: false

      timestamps()
    end

    create index(:posts, [:user_id])
    create unique_index(:posts, [:_id])
    create unique_index(:posts, [:title])
  end
end
