defmodule ArgParseTest.Consumer do
  use ArgParse.Parser

  parser do
    argument(:name, :string)
    argument(:age, :integer)

    argument :double, :boolean do
      long("-double")
      default(false)
    end

    # Specify full name of func to make tests happy
    handler(&__MODULE__.impl_handler/1)
  end

  def impl_handler(args) do
    if args.double do
      "#{args.name} is #{args.age}"
    else
      "#{args.name} is #{args.age * 2}"
    end
  end
end

defmodule ArgParseTest do
  use ExUnit.Case
  doctest ArgParse

  @want_erl %{
    arguments: [
      %{name: :name, type: :string},
      %{name: :age, type: :integer},
      %{name: :double, type: :boolean, long: ~c"-double", default: false}
    ],
    handler: &ArgParseTest.Consumer.impl_handler/1
  }

  @want_ex %{
    arguments: [
      %{name: :name, type: :string},
      %{name: :age, type: :integer},
      %{name: :double, type: :boolean, long: "-double", default: false}
    ],
    handler: &ArgParseTest.Consumer.impl_handler/1
  }

  test "commaand" do
    assert @want_erl == ArgParseTest.Consumer.command()
    assert @want_ex == ArgParseTest.Consumer.command(convert: false)
  end

  test "parse" do
    want = %{
      name: "payton",
      age: 24,
      double: false
    }

    assert want == ArgParseTest.Consumer.parse!(["payton", "24"])
  end
end
