defmodule Twix.Repo.Migrations.AddLikesToPost do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :likes, :integer, default: 0
    end
  end
end
