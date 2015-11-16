defmodule Units do 

  @index %{:byte => [
            {:one,    1024}, 
            {:kilo,   1024},
            {:mega,   1024},  
            {:giga,   1024},  
            {:tera,   1024}, 
            {:peta,   1024}]}

  # Creates new unit
  def from(amount, quantity), do: from(amount, :one, quantity)
  def from(amount, unit, quantity) when is_atom(unit) and is_integer(amount), do: %{amount: amount, unit: unit, quantity: quantity}

  # Converts a unit to another and returns a unit
  def to(amount, quantity), do: to(amount, :one, quantity)
  def to(%{amount: amount, unit: src_unit, quantity: src_quantity}, dst_unit, dst_quantity) when is_integer(amount) and is_atom(src_unit) and is_atom(dst_unit) and is_atom(dst_quantity) and src_quantity == dst_quantity do
    index = @index[dst_quantity]
    %{amount: (convert index, amount, unit_index(index, src_unit), unit_index(index, dst_unit)), unit: dst_unit, quantity: dst_quantity}
  end

  # Converts a unit to another and returns an integer. Short for to/2 |> int/1
  def to_int(amount, quantity), do: to_int(amount, :one, quantity)
  def to_int(amount, dst_unit, quantity), do: to(amount, dst_unit, quantity) |> int

  # Converts a unit to another and returns a float. Short for to/2 |> float/1
  def to_float(amount, quantity), do: to_float(amount, :one, quantity)
  def to_float(amount, dst_unit, quantity), do: to(amount, dst_unit, quantity) |> float

  # Returns the amount as an integer
  def int(%{amount: amount}) when is_integer(amount), do: amount
  def int(%{amount: amount}) when is_float(amount),   do: Float.floor amount

  # Returns the amount as a float
  def float(%{amount: amount}), do: amount

  defp unit_index(index, unit) when is_atom(unit), do: Enum.find_index(index, fn {x, _} -> x == unit end)

  defp convert(index, amount, src, dst) when src < dst do
    {_, step} = Enum.at(index, src)
    convert index, (amount / step), src + 1, dst
  end

  defp convert(index, amount, src, dst) when src > dst do
    {_, step} = Enum.at(index, src)
    convert index, (amount * step), src - 1, dst
  end

  defp convert(_, amount, src, dst) when src == dst, do: amount

end
