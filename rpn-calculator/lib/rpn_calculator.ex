defmodule RPNCalculator do
  def calculate!(stack, operation), do: operation.(stack)

  def calculate(stack, operation) do
    try do
      res = operation.(stack)
      {:ok, res}
    rescue
      _ -> :error
    end
  end

  def calculate_verbose(stack, operation) do
    try do
      res = operation.(stack)
      {:ok, res}
    rescue
      e -> {:error, e.message}
    end
  end
end
