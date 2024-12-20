defmodule ArgParse do
  def to_erl({kw, meta, args}) do
    {kw, meta, to_erl(args)}
  end

  def to_erl({key, val}) do
    {key, to_erl(val)}
  end

  def to_erl(args) when is_list(args) do
    Enum.map(args, &to_erl/1)
  end

  def to_erl(args) when is_map(args) do
    for {k, v} <- args, into: %{} do
      {k, to_erl(v)}
    end
  end

  def to_erl(args) when is_binary(args) do
    String.to_charlist(args)
  end

  def to_erl(args), do: args
end
