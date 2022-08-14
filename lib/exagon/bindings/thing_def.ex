defmodule Exagon.Bindings.ThingDef do
  defstruct [:name, :binding, :gateways, :channels, :label, :description, :properties]
  alias Exagon.Bindings.ChannelDef
  alias Exagon.Bindings.PropertyDef

  @doc false
  defmacro __using__(_) do
    quote do
      import Exagon.Bindings.ThingDef

      Module.register_attribute(__MODULE__, :exagon_thing_properties, accumulate: true)
      Module.register_attribute(__MODULE__, :exagon_thing_properties_def, accumulate: true)
      Module.register_attribute(__MODULE__, :exagon_thing_channels, accumulate: true)
      Module.register_attribute(__MODULE__, :exagon_thing_channels_def, accumulate: true)
      @exagon_thing_label ""
      @exagon_thing_description ""
    end
  end

  defmacro defthing(name, binding, do: block) do
    quote do
      if line = Module.get_attribute(__MODULE__, :exagon_thing_defined) do
        raise "thing already defined for #{inspect(__MODULE__)} on line #{line}"
      end

      @exagon_thing_defined unquote(__CALLER__.line)

      if unquote(name) |> to_string() |> String.trim() == "" do
        raise "thing name can't be empty"
      end

      @exagon_thing_binding (case Code.ensure_compiled(unquote(binding)) do
                               {:module, _} ->
                                 unquote(binding)

                               {:error, _} ->
                                 raise "Binding #{inspect(unquote(binding))} not found or not compiled"
                             end)

      @exagon_thing_name apply(@exagon_thing_binding, :name, []) <> ":" <> unquote(name)

      # Properties and Channel
      unquote(block)

      defstruct [
                  {:__def__,
                   %Exagon.Bindings.ThingDef{
                     name: @exagon_thing_name,
                     binding: @exagon_thing_binding,
                     label: @exagon_thing_label,
                     description: @exagon_thing_desciption,
                     properties: @exagon_thing_properties_def |> Enum.reverse(),
                     channels: @exagon_thing_channels_def |> Enum.reverse()
                   }},
                  {:channels, @exagon_thing_channels}
                  | @exagon_thing_properties
                ]
                |> Enum.reverse()
    end
  end

  defmacro label(label) do
    quote do
      Module.put_attribute(__MODULE__, :exagon_thing_label, unquote(label))
    end
  end

  defmacro description(description) do
    quote do
      Module.put_attribute(__MODULE__, :exagon_thing_desciption, unquote(description))
    end
  end

  defmacro gateways(gw) do
    quote do
      Module.put_attribute(__MODULE__, :exagon_thing_gateways, unquote(gw))
    end
  end

  defmacro property(name, type \\ :string, opts \\ []) do
    quote do
      Module.put_attribute(__MODULE__, :exagon_thing_properties, {unquote(name), unquote(type)})

      # Merge properties attributes with options
      prop_def =
        struct(
          %PropertyDef{
            name: unquote(name),
            type: unquote(type)
          },
          unquote(opts)
        )

      Module.put_attribute(__MODULE__, :exagon_thing_properties_def, prop_def)
    end
  end

  defmacro channel(name, opts \\ []) do
    quote do
      Module.put_attribute(__MODULE__, :exagon_thing_channels, {unquote(name), nil})

      # Merge properties attributes with options
      channel_def =
        struct(
          %ChannelDef{
            name: unquote(name)
          },
          unquote(opts)
        )

      Module.put_attribute(__MODULE__, :exagon_thing_channels_def, channel_def)
    end
  end
end
