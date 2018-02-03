alias Backqik.DynamicSupervisor, as: DS
alias Backqik.Worker, as: BW

# {:ok, pid} = BW.start_link({Kernel, :apply, [fn v -> v end, [true]]})
# {:ok, pid} = BW.start_link({Kernel, :apply, [fn t -> if NaiveDateTime.compare(NaiveDateTime.utc_now, t) == :gt, do: true, else: :error end, [NaiveDateTime.add(NaiveDateTime.utc_now(), 10, :second)]]})

# DS.start_child({Kernel, :apply, [fn v -> v end, [:error]]})
# DS.start_child({Kernel, :apply, [fn -> raise "error" end, []]})

# DS.start_child({Kernel, :apply, [fn t -> if NaiveDateTime.compare(NaiveDateTime.utc_now, t) == :gt, do: true, else: :error end, [~N[2018-02-03 13:13:20]]]})

# DS.start_child({Kernel, :apply, [fn t -> if NaiveDateTime.compare(NaiveDateTime.utc_now, t) == :gt, do: true, else: :error end, [NaiveDateTime.add(NaiveDateTime.utc_now(), 10, :second)]]})
