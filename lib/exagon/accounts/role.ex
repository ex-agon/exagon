defmodule Exagon.Accounts.Role do
  use Exagon.Schema

  alias Exagon.Accounts.User

  schema "roles" do
    field :role_name, :string
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def create_changeset(role, attrs \\ []) do
    role
    |> cast(attrs, [:role_name])
    |> validate_required([:role_name])
  end
end
