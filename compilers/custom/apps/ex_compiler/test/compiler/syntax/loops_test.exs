defmodule Compiler.Syntax.LoopsTest do
  use ExUnit.Case, async: true

  test "while loop compiles" do
    val = "
    class TestL1() {
      void test(){
        while(true){
          i += 1
        }
      }
    }
    "
    assert(ExCompiler.compile(val) == :ok)
  end

  test "complex conditional while loop compiles" do
    val = "
    class TestL2() {
      void test(){
        while(!(1 < i)){
          i += 1
        }
      }
    }
    "
    assert(ExCompiler.compile(val) == :ok)
  end
end
