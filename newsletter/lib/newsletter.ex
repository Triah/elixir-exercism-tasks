defmodule Newsletter do
  def read_emails(path) do
    {_, content} = File.read(path)
    if content != "", do: String.trim(content) |> String.split("\n"), else: []
  end

  def open_log(path), do: File.open!(path, [:write])

  def log_sent_email(pid, email), do: IO.puts(pid, email)

  def close_log(pid), do: File.close(pid)

  def send_newsletter(emails_path, log_path, send_fun) do
    pid = open_log(log_path)
    read_emails(emails_path) |> Enum.map(fn x -> if send_fun.(x) == :ok, do: log_sent_email(pid, x), else: :error end)
    close_log(pid)
  end
end
