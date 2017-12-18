defmodule EventScoring.StageSupervisor do
  use Supervisor
  alias EventScoring.{Producer, Consumer}

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_) do
    children = [
      worker(Producer, []),
      worker(Consumer, []),
    ]

    supervise(children, strategy: :one_for_one)
  end
end
