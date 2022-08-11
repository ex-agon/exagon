defmodule Exagon.Things.Thing do
  use Exagon.Schema

  alias Exagon.Accounts.Workplace

  schema "things" do
    field :path, :string

    field :status, Ecto.Enum,
      values: [:uninitialized, :initializing, :available, :online, :offline, :unknown]

    field :status_detail, :string
    field :binding_attrs, :map
    belongs_to :workplace, Workplace

    timestamps()
  end

  @doc false
  def changeset(thing, attrs) do
    thing
    |> cast(attrs, [:type, :uid, :status, :status_detail])
    |> validate_required([:type, :uid, :status])
    |> unique_constraint(:path)
  end
end
