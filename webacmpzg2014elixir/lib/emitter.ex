defmodule WebCamp.Emitter do
  # http://elixir-lang.org/getting_started/11.html
  def start_link() do
    pid = spawn_link fn -> loop() end
    {:ok, pid}
  end
  defp loop() do
    receive do
      x    -> IO.inspect "Emitter got #{inspect x}"
              loop()
    after
      1000 -> pid = :gproc.where({:n, :l, WebCamp.Counter})
              send(pid, {:"$gen_cast", :inc})
              loop()
    end
  end
end
