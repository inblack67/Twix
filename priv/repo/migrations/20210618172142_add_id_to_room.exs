defmodule Twix.Repo.Migrations.AddIdToRoom do
  use Ecto.Migration

  def change do
    alter table(:rooms) do
      add(:_id, :string, null: false)
    end
    create(unique_index(:rooms, [:_id]))
  end
end
