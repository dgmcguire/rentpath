defmodule EventScoringWeb.Router do
  use EventScoringWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", EventScoringWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/api", EventScoringWeb do
    pipe_through :api
    post "/events", EventController, :create
    post "/hooks", HookController, :create
  end

  # Other scopes may use custom stacks.
  # scope "/api", EventScoringWeb do
  #   pipe_through :api
  # end
end
