defmodule Exagon.Bindings.Impl.MqttBinding do
  use Exagon.Bindings

  defbinding("mqtt", "MQTT Binding", "Some MQTT description")

  @impl true
  def start_binding() do
  end
end
