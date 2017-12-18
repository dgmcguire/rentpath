defmodule EventScoringWeb.EventChannel do
  use Phoenix.Channel

  def join("events:all", _message, socket) do
    {:ok, socket}
  end
end
