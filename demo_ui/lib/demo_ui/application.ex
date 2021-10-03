defmodule DemoUi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      DemoUiWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: DemoUi.PubSub},
      # Start the Endpoint (http/https)
      DemoUiWeb.Endpoint
      # Start a worker by calling: DemoUi.Worker.start_link(arg)
      # {DemoUi.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DemoUi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DemoUiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
