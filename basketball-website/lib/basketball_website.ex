defmodule BasketballWebsite do
  def extract_from_path(data, path) do
    [head | tail] = String.split(path, ".")
    if length(tail) > 0, do: extract_from_path(data[head], Enum.join(tail, ".")), else: data[head]
  end

  def get_in_path(data, path) do
    Kernel.get_in(data, String.split(path, "."))
  end
end
