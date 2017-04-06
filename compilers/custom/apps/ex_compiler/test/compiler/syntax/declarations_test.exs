defmodule Compiler.Syntax.DeclarationsTest do
  use ExUnit.Case, async: true

  test "declaration compiles" do
    val = "
    class TestD1() {
      void test(){
        i = 1
      }
    }
    "
    assert(ExCompiler.compile(val) == :ok)
  end

  test "multiple declarations compiles" do
    val = "
    class TestD2() {
      void test(){

      }
      void test2(){

      }
    }
    "
    assert(ExCompiler.compile(val) == :ok)
  end

  test "simple single line declaration compiles" do
    val = "
    class TestD3() {
      void test(){}
    }
    "
    assert(ExCompiler.compile(val) == :ok)
  end

  test "multiple single line declarations compiles" do
    val = "
    class TestD4() {
      void test(){}
      void test2(){}
    }
    "
    assert(ExCompiler.compile(val) == :ok)
  end

  test "declaration with parameter compiles" do
    val = "
    class TestD5() {
      void test(parm1){}
    }
    "
    assert(ExCompiler.compile(val) == :ok)
  end

  test "declaration with parameters compiles" do
    val = "
    class TestD6() {
      void test(parm1, parm2){}
    }
    "
    assert(ExCompiler.compile(val) == :ok)
  end
end
