defmodule RunnerTest do
  use ExUnit.Case, async: true

  defmodule SomeSpec do
    use ESpec

    before do
      {:ok, a: 10}
    end
    it do: "a = #{__[:a]}"

    context "Context" do
      let :a, do: 20

      it do: "a = #{a}"
    end
  end

  test "run_examples" do
    examples = ESpec.Runner.run_examples(SomeSpec.examples)
    assert(List.first(examples).status == :success)
    assert(List.last(examples).status == :success)
  end
end