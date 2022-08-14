defmodule Exagon.Bindings do
  use Agent

  defmacro __using__(_) do
    quote do
      @behaviour Exagon.Bindings
      import Exagon.Bindings, only: [defbinding: 3]
    end
  end

  defmacro defbinding(n, l, d) do
    quote do
      if line = Module.get_attribute(__MODULE__, :exagon_binding_defined) do
        raise "binding already defined for #{inspect(__MODULE__)} on line #{line}"
      end

      @exagon_binding_defined unquote(__CALLER__.line)

      if unquote(n) |> to_string() |> String.trim() == "" do
        raise "binding name can't be empty"
      end

      @exagon_binding_name unquote(n)

      def name, do: @exagon_binding_name
      def label, do: unquote(l)
      def description, do: unquote(d)
    end
  end

  @callback start_binding() :: :ok | {:error, String.t()}

  def start_link(_) do
    Agent.start_link(&build_bindings_map/0, name: __MODULE__)
  end

  def get_bindings do
    Agent.get(__MODULE__, & &1)
  end

  # Build of a map of all modules implementing the Exagon.Bindings behaviour
  defp build_bindings_map() do
    {:ok, modules} = :application.get_key(:exagon, :modules)

    for m <- modules,
        name = Atom.to_string(m),
        String.starts_with?(name, "Elixir.Exagon.Bindings.Impl"),
        binding = String.replace_prefix(name, "Elixir.Exagon.Bindings.Impl.", ""),
        module = Module.concat(Exagon.Bindings.Impl, binding),
        behaviours = module.__info__(:attributes) |> Keyword.get(:behaviour),
        Enum.find(behaviours, fn b ->
          if b == Exagon.Bindings do
            true
          else
            false
          end
        end),
        binding_name = module.name do
      {binding_name, module}
    end
    |> Map.new()
  end
end
