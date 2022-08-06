defmodule Exagon.Accounts.Workplace do
  use Exagon.Schema

  schema "workplaces" do
    field :name, :string

    timestamps()
  end

  @doc false
  def create_changeset(workplace, attrs \\ %{}) do
    workplace
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
