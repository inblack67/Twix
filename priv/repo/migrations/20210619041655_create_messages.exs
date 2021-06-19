defmodule Twix.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :content, :text, null: false
      add :type, :string, null: false
      add :_id, :string, null: false
      add :user_id, references(:users, on_delete: :delete_all)
      add :room_id, references(:rooms, on_delete: :delete_all)

      timestamps()
    end

    create index(:messages, [:user_id])
    create index(:messages, [:room_id])
    create unique_index(:messages, [:_id])
  end
end
