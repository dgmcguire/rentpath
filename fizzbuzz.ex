defmodule Rentpath do
  @doc """
  Any number divisible by three is replaced by the word fizz
  and any divisible by five by the word buzz.
  Numbers divisible by both become fizzbuzz.
  Numbers not divisible by three or five return unchanged.
  iex> fizzbuzz(1)
  1
  iex> fizzbuzz(3)
  "fizz"
  iex> fizzbuzz(5)
  "buzz"
  iex> fizzbuzz(30)
  "fizzbuzz"
  """

  def fizzbuzz(number) do
    cond do
      rem(number, 3) == 0 && rem(number,5) == 0 ->
        "fizzbuzz"
      rem(number, 3) == 0 -> "fizz"
      rem(number, 5) == 0 -> "buzz"
      true -> number
    end
  end
end

for number <- ( 1..30 ) do
  IO.inspect number, label: "number"
  IO.inspect Rentpath.fizzbuzz(number)
end
