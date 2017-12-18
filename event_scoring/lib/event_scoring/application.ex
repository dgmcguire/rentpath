defmodule EventScoring.Application do
  use Application
  import Supervisor.Spec

  def start(_type, _args) do
    children = [
      supervisor(EventScoringWeb.Endpoint, []),
      supervisor(EventScoring.StageSupervisor, []),
      supervisor(Registry, [:unique, UserRegistry]),
      worker(EventScoring.EventScores, [])
    ]

    opts = [strategy: :one_for_one, name: EventScoring.Supervisor]
    Supervisor.start_link(children, opts)
  end


  def config_change(changed, _new, removed) do
    EventScoringWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
