defmodule PlugAuth.ItemController do
  use PlugAuth.Web, :controller

  def index(conn, _params) do
    conn
    |> render( "index.json", %{items: items} )
  end

  defp items do
    [
      %{id: 1, description: "A thing"},
      %{id: 2, description: "Another thing"},
    ]
  end

end
