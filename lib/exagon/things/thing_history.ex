defmodule Exagon.Things.ThingHistory do
  use Exagon.Schema
  alias Exagon.Things.Thing

  schema "thing_history" do
    belongs_to :thing, Thing
    field :old_status, :string
    field :new_status, :string
    timestamps(inserted_at: true)
  end

  @doc false
  def changeset(thing_history, attrs) do
    thing_history
    |> cast(attrs, [:old_status, :new_status])
    |> validate_required([])
  end
end
