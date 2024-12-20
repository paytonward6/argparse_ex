defmodule ArgParse.Compatibility do
  def to_erl({a, b, c, d}), do: {to_erl(a), to_erl(b), to_erl(c), to_erl(d)}

  def to_erl({kw, meta, args}), do: {kw, to_erl(meta), to_erl(args)}

  def to_erl({key, val}), do: {key, to_erl(val)}

  def to_erl(args) when is_binary(args), do: String.to_charlist(args)

  def to_erl(args) when is_list(args), do: Enum.map(args, &to_erl/1)

  def to_erl(args) when is_map(args) do
    for {k, v} <- args, into: %{} do
      {k, to_erl(v)}
    end
  end

  def to_erl(args), do: args

  def from_erl({a, b, c, d}), do: {from_erl(a), from_erl(b), from_erl(c), from_erl(d)}

  def from_erl({kw, meta, args}), do: {kw, from_erl(meta), from_erl(args)}

  def from_erl({key, val}), do: {key, from_erl(val)}

  def from_erl(args) when is_list(args) do
    if List.ascii_printable?(args) do
      to_string(args)
    else
      Enum.map(args, &from_erl/1)
    end
  end

  def from_erl(args) when is_map(args) do
    for {k, v} <- args, into: %{} do
      {k, from_erl(v)}
    end
  end

  def from_erl(args), do: args
end
