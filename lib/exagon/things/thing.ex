defmodule Exagon.Things.Thing do
  use Exagon.Schema

  alias Exagon.Accounts.Workplace

  schema "things" do
    field :type, :string
    field :uid, :string
    belongs_to :workplace, Workplace

    timestamps()
  end

  @doc false
  def changeset(thing, attrs) do
    thing
    |> cast(attrs, [])
    |> validate_required([])
  end
end
