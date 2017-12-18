defmodule User do
  use Agent

  def start_link(user_name) do
    name = via_tuple(user_name)
    Agent.start_link(fn -> 0 end, name: name)
  end

  defp via_tuple(user_name) do
    {:via, Registry, {UserRegistry, user_name}}
  end

  def new_event(event) do
    %{user: user_name, event_type: event_type} = event
    pid = find_or_create_user(user_name)
    event_score = EventScoring.EventScores.get_event_score(event_type)
    new_score = Agent.get_and_update(pid, update_event_score_fn(event_score))
    {:ok, new_score}
  end

  defp update_event_score_fn(event_score) do
    fn score ->
      new_score = score + event_score
      { new_score, new_score }
    end
  end

  defp find_or_create_user(user_name) do
    case User.start_link(user_name) do
      {:ok, pid} -> pid
      {:error, {_, pid} } -> pid
    end
  end
end
