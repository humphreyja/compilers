defmodule Compiler.Syntax.ConditionalsTest do
  use ExUnit.Case, async: true

  test "conditional if compiles" do
    val = "
    class TestC1() {
      void test(){
        if (true) {
          i = 1
        }
      }
    }
    "
    assert(ExCompiler.compile(val) == :ok)
  end

  test "conditional if else compiles" do
    val = "
    class TestC2() {
      void test(){
        if (true) {
          i = 1
        }else{
          i = 2
        }
      }
    }
    "
    assert(ExCompiler.compile(val) == :ok)
  end

  test "compare two numbers conditional compiles" do
    val = "
    class TestC3() {
      void test(){
        if (1 == 1) {
          i = 1
        }
      }
    }
    "
    assert(ExCompiler.compile(val) == :ok)
  end

  test "compare two variables conditional compiles" do
    val = "
    class TestC4() {
      void test(){
        if (i == g) {
          i = 1
        }
      }
    }
    "
    assert(ExCompiler.compile(val) == :ok)
  end

  test "compare two function results conditional compiles" do
    val = "
    class TestC5() {
      void test(){
        if (i.to_int() == g.to_int()) {
          i = 1
        }
      }
    }
    "
    assert(ExCompiler.compile(val) == :ok)
  end

  test "conditional AND compiles" do
    val = "
    class TestC6() {
      void test(){
        if (true and true) {
          i = 1
        }
      }
    }
    "
    assert(ExCompiler.compile(val) == :ok)
  end

  test "conditional OR compiles" do
    val = "
    class TestC7() {
      void test(){
        if (true or true) {
          i = 1
        }
      }
    }
    "
    assert(ExCompiler.compile(val) == :ok)
  end

  test "conditional NOT compiles" do
    val = "
    class TestC8() {
      void test(){
        if (!true) {
          i = 1
        }
      }
    }
    "
    assert(ExCompiler.compile(val) == :ok)
  end

  test "grouped conditional compiles" do
    val = "
    class TestC9() {
      void test(){
        if (!(1 < i) and true) {
          i = 1
        }
      }
    }
    "
    assert(ExCompiler.compile(val) == :ok)
  end
end
