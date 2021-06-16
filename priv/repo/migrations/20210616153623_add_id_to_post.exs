defmodule Twix.Repo.Migrations.AddIdToPost do
  use Ecto.Migration

  def change do
    create unique_index(:posts, [:_id])
  end
end
