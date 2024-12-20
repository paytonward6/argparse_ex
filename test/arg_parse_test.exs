defmodule ArgParseTest.Consumer do
  import ArgParse

  args(%{
    arguments: [
      %{name: :name, type: :string, long: "-name"},
      %{name: :age, type: :integer, long: "-age"}
    ],
    # Specify full name of func to make tests happy
    handler: &__MODULE__.handler/1
  })

  def handler(_), do: "handled"
end

defmodule ArgParseTest do
  use ExUnit.Case
  doctest ArgParse

  test "specification map" do
    want = %{
      arguments: [
        %{name: :name, type: :string, long: ~c"-name"},
        %{name: :age, type: :integer, long: ~c"-age"}
      ],
      handler: &ArgParseTest.Consumer.handler/1
    }

    got = ArgParseTest.Consumer.specification() 

    assert want == got
  end
end
