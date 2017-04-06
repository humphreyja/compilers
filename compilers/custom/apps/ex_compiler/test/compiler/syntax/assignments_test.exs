defmodule Compiler.Syntax.AssignmentsTest do
  use ExUnit.Case, async: true

  test "assignment compiles" do
    val = "
    class TestA1() {
      void test(){
        int a = 1
      }
    }
    "
    assert(ExCompiler.compile(val) == :ok)
  end

  test "multiple assignments compiles" do
    val = "
    class TestA2() {
      void test(){
        int a = 1
        int b = 2
      }
    }
    "
    assert(ExCompiler.compile(val) == :ok)
  end

  test "operation assignment compiles" do
    val = "
    class TestA3() {
      void test(){
        a += 2
      }
    }
    "
    assert(ExCompiler.compile(val) == :ok)
  end

  test "global assignment compiles" do
    val = "
    class TestA4() {
      int a = 1
    }
    "
    assert(ExCompiler.compile(val) == :ok)
  end

  test "multiple global assignments compiles" do
    val = "
    class TestA5() {
      int a = 1
      int b = 2
    }
    "
    assert(ExCompiler.compile(val) == :ok)
  end

  test "assignment with no value compiles" do
    val = "
    class TestA6() {
      void test(){
        int a
      }
    }
    "
    assert(ExCompiler.compile(val) == :ok)
  end

  test "assignments with no values compiles" do
    val = "
    class TestA7() {
      void test(){
        int a
        int b
      }
    }
    "
    assert(ExCompiler.compile(val) == :ok)
  end

  test "global assignment with no value compiles" do
    val = "
    class TestA8() {
      int a
    }
    "
    assert(ExCompiler.compile(val) == :ok)
  end

  test "global assignments with no values compiles" do
    val = "
    class TestA9() {
      int a
      int b
    }
    "
    assert(ExCompiler.compile(val) == :ok)
  end
end
