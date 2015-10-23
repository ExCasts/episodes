defmodule PlugLogger.Authentication do

  import Plug.Conn

  import Plug.Conn,          only: [put_status: 2, halt: 1]
  import Phoenix.Controller, only: [json: 2]

  def init( options ), do: options

  def call( conn, _options ) do
    conn
    |> put_status( :unauthorized )
    |> json( %{error: %{message: "Authentication failure"}} )
    |> halt
  end

end
