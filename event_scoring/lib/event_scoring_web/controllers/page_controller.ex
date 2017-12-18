defmodule EventScoringWeb.PageController do
  use EventScoringWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
