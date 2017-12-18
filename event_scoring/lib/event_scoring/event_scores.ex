defmodule EventScoring.EventScores do
  use Agent

  def start_link do
    Agent.start_link(fn -> init_scores() end, name: __MODULE__)
  end

  defp init_scores do
    %{
      "push" => 5,
      "pull_request_review_comment" => 4,
      "watch" => 3,
      "create" => 2,
      "default" => 1
    }
  end

  def get_event_score(event_type) do
    scores = Agent.get(__MODULE__, fn map -> map end)
    case Map.get(scores, event_type) do
      nil -> scores["default"]
      score -> score
    end
  end
end
