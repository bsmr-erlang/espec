defmodule Output.JsonTest do
  use ExUnit.Case, async: true

  defmodule SomeSpec do
    use ESpec

    it do: expect(1).to eq(1)
    it do: expect(1).to eq(2)
    xit do: expect(1).to eq(1)
  end

  setup_all do
    examples = ESpec.Runner.run_examples(SomeSpec.examples)
    {:ok,
      examples: examples,
      success_example: Enum.at(examples, 0),
      failed_example: Enum.at(examples, 1),
      pending_example: Enum.at(examples, 2)
    }
  end

  test "format_result", context do
    times = {{1436, 865768, 500000}, {1436, 865768, 500100}, {1436, 865768, 500200}}
    output = ESpec.Output.Json.format_result(context[:examples], times, %{})
    assert String.match?(output, ~r/"examples"/)
    assert String.match?(output, ~r/"decription"/)
    assert String.match?(output, ~r/Output\.JsonTest\.SomeSpec/)
    assert String.match?(output, ~r/Temporarily skipped with: `xit`/)
  end
end
