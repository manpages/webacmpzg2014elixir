defmodule WebCamp.Counter do
  # http://elixir-lang.org/docs/stable/elixir/GenServer.html
  use GenServer

  def init([]) do
    :gproc.reg({:n, :l, __MODULE__})
    {:ok, 0}
  end

  def start_link do
    GenServer.start_link(__MODULE__, [])
  end

  def handle_cast(anything, state) do
    IO.inspect "New state = #{state} + 1"
    {:noreply, state+1}
  end

end
