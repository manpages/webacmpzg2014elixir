defmodule WebCamp.Counter do
  # http://elixir-lang.org/docs/stable/elixir/GenServer.html
  use GenServer
  import WebCamp.Macros.Persist
  import WebCamp.Macros.OTP
  require Logger

  def otp_id(_ \\ []), do: __MODULE__

  ginit [] do
    { [{:n, :l, __MODULE__}], 
      WebCamp.Persist.get(otp_id) || 0 }
  end

  def start_link do
    GenServer.start_link(__MODULE__, [])
  end

  defwrite(:inc, state) do
    Logger.debug "New state = #{state} + 1"
    {:noreply, state+1}
  end

end
