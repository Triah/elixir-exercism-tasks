defmodule RPNCalculator.Exception do
  alias RPNCalculator.Exception.StackUnderflowError
  alias RPNCalculator.Exception.DivisionByZeroError

  def divide([]), do: raise(StackUnderflowError, "when dividing")
  def divide([_head | []]), do: raise(StackUnderflowError, "when dividing")
  def divide([0 | _tail]), do: raise(DivisionByZeroError)
  def divide([head | [first_tail | _tail]]), do: first_tail / head

  defmodule DivisionByZeroError do
    defexception message: "division by zero occurred"
  end

  defmodule StackUnderflowError do
    defexception message: "stack underflow occurred"

    @impl true
    def exception(value) do
      case value do
        [] -> %StackUnderflowError{}
        _ -> %StackUnderflowError{message: "stack underflow occurred, context: " <> value}
      end
    end
  end
end
