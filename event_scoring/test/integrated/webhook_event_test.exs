defmodule WebhookEventTest do
  use EventScoringWeb.ConnCase
  use EventScoringWeb.ChannelCase

  setup do
    EventScoringWeb.Endpoint.subscribe("events:all")
  end

  describe "POSTing events pushes to websocket" do
    test "the user score", %{conn: conn} do
      headers = [{"x-github-event","push"}, {"x-github-delivery", "some-unique-id-thingy"}]
      conn = %{ conn | req_headers: headers }
      payload = test_payload()

      post conn, event_path(conn, :create), fake_params()
      assert_broadcast "event", ^payload
      assert_broadcast "user_score", %{user: "user A", score: 5}
      # post another ever and test new score
      post conn, event_path(conn, :create), fake_params()
      assert_broadcast "user_score", %{user: "user A", score: 10}
    end
  end

  defp test_payload do
    %{ user: "user A", repo: "repo A",
      owner: "owner A", event_type: "push",
      event_id: "some-unique-id-thingy"
    }
  end

  defp fake_params do
    %{
      "repository"=>%{
        "name" => "repo A",
        "owner" => %{ "login" => "owner A" }
      },
      "sender" => %{ "login" => "user A" }
    }
  end
end
