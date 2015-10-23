defmodule PlugLogger.Authentication do

  import Plug.Conn

  import Plug.Conn,          only: [get_req_header: 2, put_status: 2, halt: 1]
  import Phoenix.Controller, only: [json: 2]

  def init( options ), do: options

  def call( conn, _options ) do
    case authorize( conn ) do
      :authorized ->
        conn
      :unauthorized ->
        conn
        |> put_status( :unauthorized )
        |> json( %{error: %{message: "Authentication failure"}} )
        |> halt
    end
  end

  defp authorize( conn ) do
    provided_token = get_req_header( conn, "auth-token" ) |> List.first

    if provided_token == token, do: :authorized, else: :unauthorized
    #cond do
      #provided_token == token -> :authorized
      #true -> :unatuhorized
    #end
  end

  defp token do
    "123456789"
  end

end
