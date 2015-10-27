defmodule Test.Supervisor do
  use Supervisor

  def start_link( args \\[] ) do
    Supervisor.start_link(__MODULE__, args, name: :TestSupervisor)
  end

  def init(args) do
    children = [
      # Define workers and child supervisors to be supervised
      worker(Test.Server, [[], [name: :Server]])
    ]

    # See http://elixir-lang.org/docs/stable/Supervisor.Behaviour.html
    # for other strategies and supported options
    supervise(children, strategy: :one_for_one)
  end
end
