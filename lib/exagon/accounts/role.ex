defmodule Exagon.Accounts.Role do
  use Exagon.Schema

  alias Exagon.Accounts.{User, Workplace}

  schema "roles" do
    field :name, :string
    belongs_to :user, User
    belongs_to :workplace, Workplace

    timestamps()
  end

  @doc false
  def create_changeset(role, attrs \\ []) do
    role
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> validate_inclusion(:name, ["admin", "owner", "user", "guest"])
    |> unique_constraint([:user, :workplace, :name], name: "roles_user_id_workplace_id_index")
  end
end
