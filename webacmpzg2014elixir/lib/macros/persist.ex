defmodule WebCamp.Macros.Persist do
  defmacro defwrite(req, from, state, body) do
    quote do
      def handle_call(unquote(req), unquote(from), unquote(state)) do
        result = unquote(body[:do])
        state1 =
          case elem(result, 0) do
            :reply   -> elem(result, 2)
            :noreply -> elem(result, 1)
            :stop    -> elem(result, 3)
          end
        WebCamp.Persist.update(otp_id(state1), state1)
        result
      end
    end
  end

  defmacro defwrite(req, state, body) do
    quote do
      def handle_cast(unquote(req), unquote(state)) do
        result = unquote(body[:do])
        state1 =
          case elem(result, 0) do
            :noreply -> elem(result, 1)
            :stop    -> elem(result, 2)
          end
        WebCamp.Persist.update(otp_id(state1), state1)
        result
      end
    end
  end
end
