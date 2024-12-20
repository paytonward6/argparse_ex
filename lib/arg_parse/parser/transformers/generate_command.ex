defmodule ArgParse.Parser.Transformers.GenerateCommand do
  use Spark.Dsl.Transformer

  def transform(dsl_state) do
    command =
      quote do
        def command(opts \\ []) do
          # Our generated code can be very simple
          # because we can get all the info we need from the module
          # in our regular ELixir code.
          ArgParse.Parser.command(__MODULE__, opts)
        end
      end

    {:ok, Spark.Dsl.Transformer.eval(dsl_state, [], command)}
  end
end
