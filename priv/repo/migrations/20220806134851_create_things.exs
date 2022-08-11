defmodule Exagon.Repo.Migrations.CreateThings do
  use Ecto.Migration

  def change do
    create table(:things, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :path, :string, null: false
      add :status, :string, null: false
      add :status_detail, :string
      add :binding_attrs, :map, default: %{}

      timestamps()
    end

    unique_index(:things, :path)
  end
end
