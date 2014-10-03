defmodule WebCamp.Macros.OTP do

  defmacro ginit(opts, body) do
    quote do
      def init(unquote(opts)) do
        {k, state} = unquote(body[:do])
        for p <- k do
          :gproc.reg(p)
        end
        {:ok, state}
      end
    end
  end

  defmacro export_state do
    quote do
      def get_state(ref \\ __MODULE__) do
        GenServer.call ref, :get_state
      end

      def handle_call(:get_state, _, state) do
        {:reply, state, state}
      end
    end
  end

end
