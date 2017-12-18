defmodule EventScoringWeb.HookController do
  use EventScoringWeb, :controller
  alias EventScoring.StageSupervisor
  alias EventScoringWeb.Endpoint
  @github_client Application.get_env(:event_scoring, :github_client)

  def create(conn, params) do
    %{"body"=>body} = params
    %{"owner" => owner, "repo" => repo} = URI.decode_query(body)
    {status, response} = @github_client.create_webhook(owner, repo)
    Endpoint.broadcast("events:all", "event", %{response: response, status: status})

    json conn, %{}
  end
  defp get_event_info(params) do
    %{ "repository" =>
      %{
        "name" => repo,
        "owner" => %{ "login" => owner }
       },
      "sender" => %{ "login" => user }
     } = params
    {owner,repo,user}
  end
end
