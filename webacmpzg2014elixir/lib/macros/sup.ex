defmodule WebCamp.Macros.Sup do
  defmacro defsup(name, opts, body) do
    quote do
      defmodule unquote(name) do
        use Supervisor

        if unquote(opts) != [] do
          def start_link do
            Supervisor.start_link(__MODULE__, [], unquote(opts))
          end
        else
          def start_link do
            Supervisor.start_link(__MODULE__, [])
          end
        end

        def init([]) do
          unquote(body[:do])
        end

      end
    end
  end
end
