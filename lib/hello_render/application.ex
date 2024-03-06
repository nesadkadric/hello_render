defmodule HelloRender.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      HelloRenderWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:hello_render, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: HelloRender.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: HelloRender.Finch},
      # Start a worker by calling: HelloRender.Worker.start_link(arg)
      # {HelloRender.Worker, arg},
      # Start to serve requests, typically the last entry
      HelloRenderWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HelloRender.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    HelloRenderWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
