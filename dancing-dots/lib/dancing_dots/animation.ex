defmodule DancingDots.Animation do
  @type dot :: DancingDots.Dot.t()
  @type opts :: keyword
  @type error :: any
  @type frame_number :: pos_integer

  @callback init(opts :: opts()) :: {:ok, term} | {:error, term}
  @callback handle_frame(dot :: DancingDots.Dot, frame_number :: number(), opts :: opts()) ::
              DancingDots.Dot

  defmacro __using__(_) do
    quote do
      @behaviour DancingDots.Animation
      def init(opts), do: {:ok, opts}
      defoverridable init: 1
    end
  end
end

defmodule DancingDots.Flicker do
  use DancingDots.Animation

  @impl DancingDots.Animation
  def handle_frame(dot, frame_number, _opts) do
    if rem(frame_number, 4) == 0, do: %{dot | opacity: dot.opacity / 2}, else: dot
  end
end

defmodule DancingDots.Zoom do
  use DancingDots.Animation

  @impl DancingDots.Animation
  def init([{:velocity, option}] = opts) when is_number(option), do: {:ok, opts}

  @impl DancingDots.Animation
  def init(opts) do
    {:error,
     "The :velocity option is required, and its value must be a number. Got: #{inspect(opts[:velocity])}"}
  end

  @impl DancingDots.Animation
  def handle_frame(dot, frame_number, _opts) when frame_number < 2, do: dot

  @impl DancingDots.Animation
  def handle_frame(dot, frame_number, opts) do
    {_res, init_options} = init(opts)
    velocity_value = init_options[:velocity]
    %{dot | radius: dot.radius + (frame_number - 1) * velocity_value}
  end
end
