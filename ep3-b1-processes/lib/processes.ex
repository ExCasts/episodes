defmodule Processes do

  def say_hello do
    IO.puts "hello"
  end

  def say( msg ) do
    IO.puts msg
  end

  def say do
    receive do
      {from, msg} ->
        IO.puts "Process #{inspect self} says: #{msg}"
        send from, "hello yourself"
        say
    end
  end

end
