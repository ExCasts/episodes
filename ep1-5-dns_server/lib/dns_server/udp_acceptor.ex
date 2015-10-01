defmodule DnsServer.UdpAcceptor do

  use GenServer

  require Logger

  # Public ##########

  def start_link(args \\ [], opts \\ []) do
    GenServer.start_link(__MODULE__, args, opts)
  end

  # Private ##########

  def init(args) do
    {:ok, port} = Keyword.fetch(List.wrap(args), :port)

    {:ok, socket} = :gen_udp.open(port, [:binary, active: true, reuseaddr: true])

    Logger.info "Accepting UDP connections on port #{port}"

    {:ok, %{port: port, socket: socket}}
  end

  def handle_info( {:udp, socket, from_ip, from_port, msg}, state ) do
    Logger.info "Received UDP message"

    :gen_udp.send(socket, from_ip, from_port, msg)

    {:noreply, state}
  end

end
