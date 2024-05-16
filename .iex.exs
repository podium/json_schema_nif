IO.puts("Using .iex.exs file loaded from #{__DIR__}/.iex.exs")

defmodule :_util do
  defdelegate exit(), to: System, as: :halt
  defdelegate q(), to: System, as: :halt
  defdelegate restart(), to: System, as: :restart

  def atom_status do
    limit = :erlang.system_info(:atom_limit)
    count = :erlang.system_info(:atom_count)

    IO.puts("Currently using #{count} / #{limit} atoms")
  end

  def cls, do: IO.puts("\ec")

  def raw(any, label \\ "iex") do
    IO.inspect(any,
      label: label,
      pretty: true,
      limit: :infinity,
      structs: false,
      syntax_colors: [
        number: :yellow,
        atom: :cyan,
        string: :green,
        nil: :magenta,
        boolean: :magenta
      ],
      width: 0
    )
  end
end

import :_util
