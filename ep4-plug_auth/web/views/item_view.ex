defmodule PlugAuth.ItemView do
  use PlugAuth.Web, :view

  def render( "index.json", %{items: items} ) do
    items
  end

end
