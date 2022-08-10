defmodule Exagon.Repo.Migrations.CreateRoles do
  use Ecto.Migration

  def change do
    create table(:roles, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :user_id, references(:users, type: :binary_id, on_delete: :delete_all), null: false

      add :workplace_id, references(:workplaces, type: :binary_id, on_delete: :delete_all),
        null: true

      add :name, :string, null: false
      timestamps()
    end

    create unique_index(:roles, [:user_id, :workplace_id])
  end
end
