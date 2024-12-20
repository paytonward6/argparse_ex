
defmodule ArgParseTest.Consumer do
  use ArgParse.Parser

  parser do
    argument :left, :integer
    argument :right, :integer

    argument :double, :boolean do
      long "-double"
      default false
    end

    # Specify full name of func to make tests happy
    handler &__MODULE__.impl_handler/1
  end

  def impl_handler(args) do
    res = args.left + args.right
    if args.double do
      res * 2
    else
      res
    end
  end
end

ArgParseTest.Consumer.command()

dbg(ArgParseTest.Consumer.parse(["1", "2", "--doub"]))
