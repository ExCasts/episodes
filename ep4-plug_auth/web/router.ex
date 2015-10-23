defmodule PlugAuth.Router do
  use PlugAuth.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]

    plug PlugLogger.Authentication
  end

  scope "/", PlugAuth do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/api", PlugAuth do
    pipe_through :api # Use the default browser stack

    get "/items", ItemController, :index
  end
end
