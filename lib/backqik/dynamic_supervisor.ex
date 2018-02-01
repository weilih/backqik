defmodule Backqik.DynamicSupervisor do
  use DynamicSupervisor

  def start_link(arg) do
    DynamicSupervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  def init(_arg) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def start_child({m, f, a}) do
    child_spec = %{id: m, start: {m, f, a}, restart: :transient}
    DynamicSupervisor.start_child(__MODULE__, child_spec)
  end

  def count_children, do: DynamicSupervisor.count_children(__MODULE__)
  def which_children, do: DynamicSupervisor.which_children(__MODULE__)
  def terminate_child(pid), do: DynamicSupervisor.terminate_child(__MODULE__, pid)
end
