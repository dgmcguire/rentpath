defmodule UserAgentTest  do
  use ExUnit.Case, async: true

  setup_all do
    push_score = EventScoring.EventScores.get_event_score("push")
    random_score = EventScoring.EventScores.get_event_score("random")
    [ random: random_score, push: push_score ]
  end

  test "sending push event adds appropriate score", context do
    user_name = "some user"
    User.start_link(user_name)
    event = %{user: user_name, event_type: "push"}

    {:ok, score} = User.new_event(event)
    assert score == context[:push]
    {:ok, new_score} = User.new_event(event)
    assert new_score == context[:push] * 2
  end

  test "sending unspecified events results in adding default score", context do
    user_name = "different user"
    User.start_link(user_name)
    event = %{user: user_name, event_type: "anything can go here but a defined event"}

    {:ok, score} = User.new_event(event)
    assert score == context[:random]
    {:ok, new_score} = User.new_event(event)
    assert new_score == context[:random] * 2
  end
end
