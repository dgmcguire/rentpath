ExUnit.start
Code.load_file("fizzbuzz.ex", __DIR__)

defmodule FibbTest do
  use ExUnit.Case, async: true
  alias Rentpath, as: R

  test "make sure fizzbuzz works" do
    assert R.fizzbuzz(1) == 1
  end

  test "fizzbuzz by three" do
    assert R.fizzbuzz(3) == "fizz"
  end

  test "fizzbuzz by five" do
    assert R.fizzbuzz(5) == "buzz"
  end

  test "fizzbuzz by thiry" do
    assert R.fizzbuzz(30) == "fizzbuzz"
  end
end
