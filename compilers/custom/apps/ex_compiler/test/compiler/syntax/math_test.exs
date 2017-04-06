defmodule Compiler.Syntax.MathTest do
  use ExUnit.Case, async: true

  test "addition math compiles" do
    val = "
    class TestM1() {
      void test(){
        int a
        a = 1 + 1
      }
    }
    "
    assert(ExCompiler.compile(val) == :ok)
  end

  test "subtraction math compiles" do
    val = "
    class TestM2() {
      void test(){
        a = 1 - 1
      }
    }
    "
    assert(ExCompiler.compile(val) == :ok)
  end

  test "multiplication math compiles" do
    val = "
    class TestM3() {
      void test(){
        a = 1 * 1
      }
    }
    "
    assert(ExCompiler.compile(val) == :ok)
  end

  test "division math compiles" do
    val = "
    class TestM4() {
      void test(){
        a = 1 / 1
      }
    }
    "
    assert(ExCompiler.compile(val) == :ok)
  end

  test "modulus math compiles" do
    val = "
    class TestM5() {
      void test(){
        a = 1 % 1
      }
    }
    "
    assert(ExCompiler.compile(val) == :ok)
  end

  test "complex equation math compiles" do
    val = "
    class TestM6() {
      void test(){
        a = (1 % 1) * 3 + 2 * (4 / 2)
      }
    }
    "
    assert(ExCompiler.compile(val) == :ok)
  end
end
