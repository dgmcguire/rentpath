defmodule EventScoringWeb.EventController do
  use EventScoringWeb, :controller

  def create(conn, params) do
    {event_type, event_id} = get_header_info(conn)
    {owner,repo,user} = get_event_info(params)
    event = %{
      event_id: event_id,
      event_type: event_type,
      owner: owner,
      repo: repo,
      user: user
    }

    GenServer.cast(EventScoring.Producer, {:event,event})
    json conn, %{}
  end

  defp get_header_info(conn) do
    event_type_filter = fn {h, _val} -> h == "x-github-event" end
    event_id_filter = fn {h, _val} -> h == "x-github-delivery" end
    [{_, event_type}] = Enum.filter(conn.req_headers, event_type_filter)
    [{_, event_id}] = Enum.filter(conn.req_headers, event_id_filter)
    {event_type, event_id}
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
