# Why You Should Use Elixir and Phoenix for Your Next Project?

Based on this [article](http://blog.plataformatec.com.br/2015/06/elixir-in-times-of-microservices) by Jose Valim.

* Elixir is expressive and pleasant to learn and work with
* Elixir borrowed lots of good ideas from Ruby (and almost every other language that has ever had a good idea)
* Elixir is appropriate for single node or milti-node distributed systems
* Phoenix borrowed lots of good ideas from Rails thus reaching the critical mass of concepts needed to order to get stuff done is not daunting
* Phoenix fixes many of Rails issues
    * Repository vs ActiveRecord pattern
    * Changesets vs. model validations, callbacks and strong parameters


## Concurrency Model

### Processes and Messaging

> Because all Elixir processes communicate with each other via message passing, the runtime provides a feature called location 
> transparency. This means it doesn’t really matter if two processes are in the same node or in different ones, they are still 
> able to exchange messages. - Jose Valim

Simplest example:

    pid = spawn(fn -> IO.puts "hello" end)
    Process.alive?(pid)

A simple module example:

    defmodule Processes do
      def say_hello do
        IO.puts "hello"
      end

      def say(msg) do
        IO.puts msg
      end
    end

    spawn(Processes, :say_hello, [])
    spawn(Processes, :say, ["Jason"])

Getting the PID example:

    self
    spawn(fn -> IO.puts(inspect(self)) end)

A simple message passing example:

    defmodule Processes do
      def say do
        receive do
          {from, msg} ->
            IO.puts "Process #{inspect self} says: #{msg}"
        end
      end
    end

    pid = spawn(Processes, :say, [])
    send(pid, {self, "hello"})
    send(pid, {self, "hello"}) # no output this time
    Process.alive?(pid)

A simple recursive message passing example:

    defmodule Processes do
      def say do
        receive do
          {from, msg} ->
            IO.puts "Process #{inspect self} says: #{msg}"
            say
        end
      end
    end

    pid = spawn(Processes, :say, [])
    send(pid, {self, "hello"})
    send(pid, {self, "hello"}) # with output this time

A simple message passing example with a reply message:

    defmodule Processes do
      def say do
        receive do
          {from, msg} ->
            IO.puts "Process #{inspect self} says: #{msg}"
            send(from, "hello yourself")
            say
        end
      end
    end

    pid = spawn(Processes, :say, [])
    send(pid, {self, "hello"}) # no reply message represented
    flush

    # now handle reply with receive
    receive do
      msg -> IO.puts("handled msg: #{msg}"
    end

### GenServer (Generic Server)

The GenServer is an abstraction that will have a standard set of interface functions and include functionality for tracing 
and error reporting. It will also have the interface necessary to be placed into a supervision tree.

A GenServer is a process like any other Elixir process and it can be used to keep state, execute code asynchronously and 
so on.

Example forthcoming in next section.


## OTP (Open Telecom Platform)

In a time when starting monolithic and refactoring to micro-services is popular, why not use a language with tooling 
that facilitates this from the beginning of a project?

> In Elixir, breaking a large application into smaller ones is simpler than anywhere else, as the process tree 
> already outlines dependencies and the communication between those dependencies always happen explicitly via 
> message passing. - Jose Valim

### Umbrella Projects

Mix provides a feature called umbrella projects where you have a project composed of many applications that may depend on 
each other on any fashion.

Umbrella projects allows you to compile, test and run each application as a unit but also perform all the tasks at once if 
required. 

### Applications

In Elixir (actually, in Erlang/OTP), an application is a component implementing some specific functionality, 
that can be started and stopped as a unit, and which can be re-used in other systems. An application is a 
grouping of at least one worker process and possibly one or more supervisors that work together to deliver
functionality.

Elixir has an [Application module](http://elixir-lang.org/docs/stable/elixir/Application.html) for working with 
applications and defining application callback.  The application callback is the entrypoint for starting this
application and other than that usually defines one or more top level supervisors and/or workers.

One can think of an application as a service that is running inside of the same (or another) BEAM instance.

A phoenix application is simply an OTP application.  Checkout `YourApp.Endpoint`, [Phoenix.Endpoint](https://github.com/phoenixframework/phoenix/blob/master/lib/phoenix/endpoint.ex) 
and [Phoenix.Endpoint.Adapter](https://github.com/phoenixframework/phoenix/blob/master/lib/phoenix/endpoint/adapter.ex).

### Supervisors

A supervisor is a process which supervises other processes, called child processes. Supervisors are used to build a 
hierarchical process structure called a supervision tree, a nice way to structure fault-tolerant applications.

### Libraries

A library is a grouping of Elixir modules/functions that can be used in other libraries or applications.

Analagous to Ruby/Rails vendored gems.
  
    def deps do
      [
        {:some_lib, "~> 1.0", in_umbrella: true}
      ]
    end

### Multiple Phoenix Applications

### Oberserver

    :observer.start
