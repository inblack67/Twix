defmodule Twix.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :content, :string, null: false
      add :title, :string, null: false
      add :image_urls, {:array, :string}, null: false, default: []
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:posts, [:user_id])
  end
end
