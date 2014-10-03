defmodule WebCamp.Persist do
  use GenServer

  @dump_file (:code.priv_dir(:webacmpzg2014elixir) |> to_string) <> "/state"
  @reductions 0

  def update(otpid, state) do
    GenServer.cast __MODULE__, {:update, {otpid, state}}
  end

  def get_state do
    GenServer.call __MODULE__, :get_state
  end

  def get(key) do
    GenServer.call __MODULE__, {:get, key}
  end

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init([]) do
    {:ok, {@reductions, read_state()}}
  end

  def handle_call({:get, key}, _from, {reductions, state}) do
    {:reply, state[key], {reductions, state}}
  end

  def handle_call(:get_state, _from, {reductions, state}) do
    {:reply, state, {reductions, state}}
  end

  def handle_cast({:update, {otpid, entity_state}}, {0, state}) do
    state = HashDict.put state, otpid, entity_state
    write_state(state)
    {:noreply, {@reductions, state}}
  end
  def handle_cast({:update, {otpid, entity_state}}, {reductions, state}) do
    {:noreply, {reductions - 1, HashDict.put(state, otpid, entity_state)}}
  end

  def terminate(_, state) do
    write_state(state)
  end

  defp read_state do
    try do
      @dump_file
      |> File.read!
      |> :erlang.binary_to_term
    rescue
      _ -> HashDict.new
    end
  end

  defp write_state(state) do
    :ok = File.write! @dump_file, (state |> :erlang.term_to_binary)
  end

end
