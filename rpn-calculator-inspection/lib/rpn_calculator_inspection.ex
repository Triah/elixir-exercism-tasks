defmodule RPNCalculatorInspection do
  def start_reliability_check(calculator, input) do
    process = spawn_link(fn -> calculator.(input) end)
    %{input: input, pid: process}
  end

  def await_reliability_check_result(%{pid: pid, input: input}, results) do
    receive do
      {:EXIT, ^pid, :normal} -> Map.put(results, input, :ok)
      {:EXIT, ^pid, _} -> Map.put(results, input, :error)
    after
      100 -> Map.put(results, input, :timeout)
    end
  end

  def reliability_check(calculator, inputs) do
    trap = Process.flag(:trap_exit, true)

    calculation =
      Enum.map(inputs, fn input -> start_reliability_check(calculator, input) end)
      |> Enum.reduce(%{}, &await_reliability_check_result/2)

    Process.flag(:trap_exit, trap)
    calculation
  end

  def correctness_check(calculator, inputs) do
    Enum.map(inputs, fn input -> Task.async(fn -> calculator.(input) end) end)
    |> Enum.map(fn calculation -> Task.await(calculation, 100) end)
  end
end
