defmodule ArgParse.Parser.Info do
  use Spark.InfoGenerator,
    extension: ArgParse.Parser.Dsl,
    sections: [:parser]
end
