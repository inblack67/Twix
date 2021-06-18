defmodule Twix.Repo.Migrations.CreateRooms2 do
  use Ecto.Migration

  def change do
    create table(:rooms) do
      add :name, :string, null: false
      add :description, :string, null: false
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:rooms, [:user_id])
    create unique_index(:rooms, [:name])
  end
end
