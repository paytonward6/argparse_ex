defmodule ArgParse.Parser.Transformers.GenerateRun do
  use Spark.Dsl.Transformer

  def transform(dsl_state) do
    run =
      quote do
        def run(argv \\ System.argv()) do
          # Our generated code can be very simple
          # because we can get all the info we need from the module
          # in our regular ELixir code.
          ArgParse.Parser.run(__MODULE__, argv)
        end
      end

    {:ok, Spark.Dsl.Transformer.eval(dsl_state, [], run)}
  end
end
