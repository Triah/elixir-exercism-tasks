# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(opts \\ []) do
    Agent.start(fn -> %{plots: [], id: 0} end, opts)
  end

  def list_registrations(pid) do
    Agent.get(pid, fn list -> list[:plots] end)
  end

  def register(pid, register_to) do
    Agent.update(pid, fn nxt ->
      nxt_id = nxt.id + 1
      %{plots: [%Plot{plot_id: nxt_id, registered_to: register_to}], id: nxt_id}
    end)

    [head | _] = list_registrations(pid)
    head
  end

  def release(pid, plot_id) do
    Agent.update(pid, fn state ->
      %{state | plots: Enum.reject(state.plots, fn x -> x.plot_id == plot_id end)}
    end)
  end

  def get_registration(pid, plot_id) do
    Enum.find(list_registrations(pid), {:not_found, "plot is unregistered"}, fn state ->
      state.plot_id == plot_id
    end)
  end
end
