defmodule Rentpath.Fibonacci do
  @doc """
  The fibonacci sequence begins with 0 and 1.
  After this, every element is the sum of the preceding elements
  iex> fibonacci(10)
  [0, 1, 1, 2, 3, 5, 8, 13, 21, 34]
  """
  def fib(0), do: [0]
  def fib(1), do: [0,1]
  def fib(number) do
    exclusive_range = number - 1
    Enum.reduce((2..exclusive_range), [0,1], &fun/2)
  end

  defp fun(_, acc) do
    {:ok, first} = Enum.fetch(acc, -1)
    {:ok, second} = Enum.fetch(acc, -2)
    previous_two_added = first + second
                         |>List.wrap
    List.flatten([ acc | previous_two_added  ])
  end

end

# Calculate the first 10 digits of the fibonacci sequence.
