defmodule ArgParse.Parser.Transformers.GenerateParse do
  use Spark.Dsl.Transformer

  def transform(dsl_state) do
    parse =
      quote do
        def parse(argv \\ System.argv()) do
          # Our generated code can be very simple
          # because we can get all the info we need from the module
          # in our regular ELixir code.
          ArgParse.Parser.parse(__MODULE__, argv)
        end
      end

    parse! =
      quote do
        def parse!(argv \\ System.argv()) do
          # Our generated code can be very simple
          # because we can get all the info we need from the module
          # in our regular ELixir code.
          ArgParse.Parser.parse!(__MODULE__, argv)
        end
      end

    dsl_state =
      dsl_state
      |> Spark.Dsl.Transformer.eval([], parse)
      |> Spark.Dsl.Transformer.eval([], parse!)

    {:ok, dsl_state}
  end
end
