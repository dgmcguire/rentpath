defmodule EventScoring.Consumer do
  use GenStage
  alias EventScoring.Producer

  def start_link do
    GenStage.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_) do
    {:consumer, :ok, subscribe_to: [{Producer, max_demand: 1}] }
  end

  def handle_events([event], _from, state) do
    %{event_type: type, user: user} = event
    {:ok, user_score} = User.new_event(event)
    EventScoringWeb.Endpoint.broadcast("events:all", "event", event)
    EventScoringWeb.Endpoint.broadcast("events:all", "user_score", %{user: user, score: user_score})
    {:noreply, [], state}
  end
end
