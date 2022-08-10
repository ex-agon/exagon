defmodule Exagon.Repo.Migrations.CreateThingHistory do
  use Ecto.Migration

  def change do
    create table(:thing_history, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :thing_id, references(:things, type: :binary_id, on_delete: :delete_all), null: false
      add :old_status, :string, null: false
      add :new_status, :string, null: false
      timestamps(inserted_at: true)
    end
  end
end
