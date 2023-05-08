defmodule LogLevel do
  def to_label(level, legacy?) do
    cond do
      level == 5 and not legacy? -> :fatal
      level == 4 -> :error
      level == 3 -> :warning
      level == 2 -> :info
      level == 1 -> :debug
      level == 0 and not legacy? -> :trace
      true -> :unknown
    end
  end

  def alert_recipient(level, legacy?) do
    case to_label(level, legacy?) do
      :unknown when legacy? -> :dev1
      :unknown when not legacy? -> :dev2
      e when e in [:fatal, :error] -> :ops
      _ -> false
    end
  end
end
