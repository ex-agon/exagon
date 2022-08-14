defmodule Exagon.BindingFixtures do
  defmodule TestBinding do
    use Exagon.Bindings

    defbinding("test", "test label", "test description")
  end

  defmodule TestThing do
    use Exagon.Bindings.ThingDef

    defthing "testthing", TestBinding do
      label("test label")
      description("test  description")
      property(:prop1, :string, label: "Prop1 label", description: "Prop1 description")
      property(:prop2, :string)
      channel("test_channel")
    end
  end
end
