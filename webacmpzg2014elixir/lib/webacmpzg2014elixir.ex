defmodule WebCamp do
  use Application
  def start(_type, _args) do
    WebCamp.Sup.start_link #=> {:ok, pid}
  end
end
