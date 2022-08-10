defmodule Exagon.Repo.Migrations.CreateThings do
  use Ecto.Migration

  def change do
    create table(:things, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :uid, :string, null: false
      add :status, :string, null: false
      add :status_detail, :string

      timestamps()
    end
  end
end
