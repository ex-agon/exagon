defmodule Exagon.Bindings.Impl.Mqtt.MqttThinex do
  use Exagon.Bindings.ThingDef

  defthing "thing", Exagon.Bindings.Impl.MqttBinding do
    label("MQTT Thing label")
    description("MQTT Thing description")
    property(:prop1, :string, label: "Prop1 label", description: "Prop1 description")
    property(:prop2, :string)
    channel("test_channel")
  end
end
