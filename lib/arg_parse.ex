defmodule ArgParse do
  defmacro args(specification) do
    spec = convert(specification)

    quote do
      def specification(), do: unquote(spec)
    end
  end

  def convert({kw, meta, args}) do
    {kw, meta, convert(args)}
  end

  def convert({key, val}) do
    {key, convert(val)}
  end

  def convert(args) when is_list(args) do
    Enum.map(args, &convert/1)
  end

  def convert(args) when is_map(args) do
    for {k, v} <- args, into: %{} do
      {k, convert(v)}
    end
  end

  def convert(args) when is_binary(args) do
    String.to_charlist(args)
  end

  def convert(args), do: args
end
