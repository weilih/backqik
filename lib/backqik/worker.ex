defmodule Backqik.Worker do
  use GenServer

  @max_retries 25

  def start_link(mfa) do
    GenServer.start_link(__MODULE__, mfa)
  end

  def init(mfa) do
    Process.send(self(), :execute, [])

    utc_now = NaiveDateTime.utc_now()
    {:ok, %{mfa: mfa, retry: 0, created_at: utc_now, next_retry_at: utc_now}}
  end

  def handle_info(:execute, %{mfa: {m, f, a}, retry: retry_count} = state) do
    try do
      case Kernel.apply(m, f, a) do
        :error when retry_count >= @max_retries -> {:stop, :shutdown, state}
        :error -> raise "unknown error occurred"
        _ -> {:stop, :normal, state}
      end
    rescue
      _error -> reschedule_work(state)
    end
  end

  def terminate(reason, _state), do: IO.inspect(reason, label: "terminate")

  defp reschedule_work(%{retry: retry_count} = state) when retry_count >= @max_retries do
    {:stop, :shutdown, state}
  end

  defp reschedule_work(%{retry: count, next_retry_at: timestamp} = state) do
    seconds_to_delay = seconds_to_delay(count)
    next_retry_at = NaiveDateTime.add(timestamp, seconds_to_delay, :second)
    state = %{state | retry: count + 1, next_retry_at: next_retry_at}

    Process.send_after(self(), :execute, seconds_to_delay * 1_000)
    {:noreply, state}
  end

  defp seconds_to_delay(count) do
    (:math.pow(count, 4) + 15 + Enum.random(0..30) * (count + 1)) |> round()
  end
end
