defmodule PlugAuth.PageController do
  use PlugAuth.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
