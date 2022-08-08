defmodule Exagon.Repo.Migrations.CreateThings do
  use Ecto.Migration

  def change do
    create table(:things, primary_key: false) do
      add :id, :binary_id, primary_key: true

      timestamps()
    end
  end
end
