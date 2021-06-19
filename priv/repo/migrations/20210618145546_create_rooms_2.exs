defmodule Twix.Repo.Migrations.CreateRooms2 do
  use Ecto.Migration

  def change do
    create table(:rooms) do
      add :name, :string, null: false
      add :description, :string, null: false
      add :_id, :string, null: false
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:rooms, [:user_id])
    create unique_index(:rooms, [:name])
    create unique_index(:rooms, [:_id])
  end
end
