defmodule ArgParse.Parser do
  use Spark.Dsl,
    default_extensions: [
      extensions: [ArgParse.Parser.Dsl]
    ]

  @temp_parser_opts %{progname: ~c"this"}

  def run(module, argv) do
    case parse(module, argv) do
      {:ok, args, _cmd_path, command} ->
        command.handler.(args)

      {:error, reason, command} ->
        dump_error(command, reason)
    end
  end

  def parse!(module, argv) do
    case parse(module, argv) do
      {:ok, args, _cmd_path, _command} ->
        ArgParse.Compatibility.from_erl(args)

      {:error, reason, _command} ->
        raise reason
    end
  end

  def parse(module, argv) do
    argv = Enum.map(argv, &String.to_charlist/1)
    command = command(module)

    case :argparse.parse(argv, command, @temp_parser_opts) do
      {:ok, _args, _cmd_path, _command} = results ->
        ArgParse.Compatibility.to_erl(results)

      {:error, reason} ->
        {:error, ArgParse.Compatibility.from_erl(reason), command(module, convert: false)}
    end
  end

  def command(module, opts \\ []) do
    command =
      %{
        arguments: del_nil(ArgParse.Parser.Info.parser(module)),
        handler: ArgParse.Parser.Info.parser_options(module).handler
      }

    if Keyword.get(opts, :convert, true) do
      ArgParse.Compatibility.to_erl(command)
    else
      command
    end
  end

  defp dump_error(command, parse_error) do
    IO.puts(:argparse.format_error(parse_error))
    IO.puts(:argparse.help(command, @temp_parser_opts))
  end

  defp del_nil(arguments) when is_list(arguments) do
    arguments
    |> Enum.map(&Map.delete(&1, :__struct__))
    |> Enum.map(&Map.filter(&1, fn {_k, v} -> not is_nil(v) end))
  end
end
