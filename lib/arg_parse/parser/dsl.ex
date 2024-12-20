defmodule ArgParse.Parser.Dsl do
  defmodule Argument do
    defstruct [:name, :type, :long, :default]
  end

  @argument %Spark.Dsl.Entity{
    name: :argument,
    args: [:name, :type],
    target: Argument,
    describe: "A commandline argument",
    # you can include nested entities here, but
    # note that you provide a keyword list like below
    # we need to know which struct key to place the nested entities in
    # entities: [
    #   key: [...]
    # ],
    schema: [
      name: [
        type: :atom,
        required: true,
        doc: "The name of the arg"
      ],
      type: [
        type: {:one_of, [:integer, :string, :boolean]},
        required: true,
        doc: "The type of the field"
      ],
      long: [
        type: :string,
        required: false,
        doc: "Long name of argument"
      ],
      default: [
        type: :any,
        required: false,
        doc: "Default argument"
      ]
    ]
  }

  @parser %Spark.Dsl.Section{
    name: :parser,
    schema: [
      handler: [
        type: {:fun, 1},
        doc: "Handler for parser"
      ]
    ],
    entities: [
      @argument
    ],
    describe: "Configure the fields that are supported and required"
  }

  use Spark.Dsl.Extension,
    sections: [@parser],
    transformers: [
      ArgParse.Parser.Transformers.GenerateCommand,
      ArgParse.Parser.Transformers.GenerateRun,
      ArgParse.Parser.Transformers.GenerateParse
    ]
end
