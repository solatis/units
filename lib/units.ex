defmodule Units do 

  @index [{:bytes, 1024}, {:kb, 1024},  {:mb, 1024},  {:gb, 1024},  {:tb, 1024}, {:pb, 1024}]

  # Creates new unit
  def from(amount, unit) when is_atom(unit) and is_integer(amount), do: %{amount: amount, unit: unit}

  # Converts a unit to another and returns a unit
  def to(%{amount: amount, unit: src_unit}, dst_unit) when is_integer(amount) and is_atom(src_unit) and is_atom(dst_unit) do
    %{amount: (convert amount, unit_index(src_unit), unit_index(dst_unit)), unit: dst_unit}
  end

  # Converts a unit to another and returns an integer. Short for to/2 |> int/1
  def to_int(amount, dst_unit), do: to(amount, dst_unit) |> int

  # Converts a unit to another and returns a float. Short for to/2 |> float/1
  def to_float(amount, dst_unit), do: to(amount, dst_unit) |> float

  # Returns the amount as an integer
  def int(%{amount: amount}) when is_integer(amount), do: amount
  def int(%{amount: amount}) when is_float(amount),   do: Float.floor amount

  # Returns the amount as a float
  def float(%{amount: amount}), do: amount

  defp unit_index(unit) when is_atom(unit), do: Enum.find_index(@index, fn {x, _} -> x == unit end)

  defp convert(amount, src, dst) when src < dst do
    {_, step} = Enum.at(@index, src)
    convert (amount / step), src + 1, dst
  end

  defp convert(amount, src, dst) when src > dst do
    {_, step} = Enum.at(@index, src)
    convert (amount * step), src - 1, dst
  end

  defp convert(amount, src, dst) when src == dst, do: amount

end
