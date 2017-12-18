alias HTTPoison, as: HTTP

defmodule GithubClient.LiveClient do
  @base_url "https://api.github.com"
  @callback_url_base Application.get_env(:event_scoring, :callback_url_base)
  @events_url_path "/api/events"
  @temp_token Application.get_env(:event_scoring, :github_api_token)

  def create_webhook(owner, repo) do
    client = Tentacat.Client.new(%{access_token: @temp_token})
    body = all_events_hook_config()
    Tentacat.Hooks.create(owner, repo, body, client)
  end

  defp all_events_hook_config do
    url = "#{@callback_url_base}#{@events_url_path}"
    body = %{
      "name" => "web", "active" => true, "events" => [ "*" ],
      "config" => %{
        "url" => url,
        "content_type" => "json"
      }
    }
  end
end
