defmodule Compiler.Eval.MathTest do
  use ExUnit.Case, async: true

  test "evaluate simple addition" do
    val = "
    class Test() {
      void test(){
        a = 1 + 1
      }
    }
    "
    assert(ExCompiler.compile(val) == :ok)
  end
end
