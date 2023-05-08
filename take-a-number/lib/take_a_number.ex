defmodule TakeANumber do
  def start(), do: spawn(fn -> loop(0) end)

  defp loop(state) do
    receive do
      {:report_state, process} -> 
        send(process, state)
        loop(state)

      {:take_a_number, process} ->
        state = state + 1
        send(process, state)
        loop(state)

       :stop -> nil

      _ -> loop(state)
    end
  end
end
