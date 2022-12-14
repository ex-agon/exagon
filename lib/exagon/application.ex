defmodule Exagon.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Exagon.Repo,
      # Start the Telemetry supervisor
      ExagonWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Exagon.PubSub},
      # Start the Endpoint (http/https)
      ExagonWeb.Endpoint,
      # Start a worker by calling: Exagon.Worker.start_link(arg)
      Exagon.Bindings
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Exagon.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ExagonWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
