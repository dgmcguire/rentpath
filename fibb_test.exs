ExUnit.start
Code.load_file("fibb.ex", __DIR__)

defmodule FibbTest do
  use ExUnit.Case, async: true
  alias Rentpath.Fibonacci, as: R

  test 'fib seq 10' do
    assert R.fib(10) == [0, 1, 1, 2, 3, 5, 8, 13, 21, 34]
  end

  test 'fib seq 0' do
    assert R.fib(0) == [0]
  end
end
