defmodule Test.Server do
  use GenServer

  require Logger

  def start_link( args \\ [], opts \\ []) do
    GenServer.start_link(__MODULE__, args, opts)
  end

  def init([]) do
    { :ok, [] }
  end

  def hello(pid) do
    GenServer.call(pid, :hello)
  end

  def handle_call(:hello, _from, state) do
    Logger.info "call hello"
    {:reply, "world!", state}
  end
end
