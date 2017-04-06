defmodule Compiler.Syntax.ModulesTest do
  use ExUnit.Case, async: true

  test "simple module compiles" do
    val = "
    class TestMo1() {

    }
    "
    assert(ExCompiler.compile(val) == :ok)
  end

  test "multiple modules compiles" do
    val = "
    class TestMo2() {

    }

    class TestMo3() {

    }
    "
    assert(ExCompiler.compile(val) == :ok)
  end

  test "single line module compiles" do
    val = "
    class TestMo4() {}
    "
    assert(ExCompiler.compile(val) == :ok)
  end

  test "single line multiple modules compiles" do
    val = "
    class TestMo5() {}
    class TestMo6() {}
    "
    assert(ExCompiler.compile(val) == :ok)
  end

  test "inheritence module compiles" do
    val = "
    class BaseMo1(Parent) {

    }
    "
    assert(ExCompiler.compile(val) == :ok)
  end

  test "multiple inheritence module compiles" do
    val = "
    class BaseMo2(Parent1, Parent2) {

    }
    "
    assert(ExCompiler.compile(val) == :ok)
  end
end
