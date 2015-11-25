defmodule Units do 

  @moduledoc """
  Arithmetic for converting SI unit prefixes.

  ## Examples

      iex> Units.from(1, :mega, :byte) |> Units.to_int(:kilo, :byte)
      1024
      iex> Units.from(1, :mega, :byte) |> Units.to_int(:byte)
      1048576
      iex> Units.from(2, :kilo, :meter) |> Units.to_int(:centi, :meter)
      200000

  The following units of measurement are recognized:

  ### :meter

  `:pico`, `:nano`, `:micro`, `:milli`, `:centi`, `:deci`, `:deca`, `:hecto`, `:kilo`, `:mega`, `:giga`

  ### :byte

  `:kilo`, `:mega`, `:giga`, `:tera`, `:peta`

  """

  @index %{:byte => [
            {:one,    {1024, 1024}}, 
            {:kilo,   {1024, 1024}},
            {:mega,   {1024, 1024}},
            {:giga,   {1024, 1024}},  
            {:tera,   {1024, 1024}}, 
            {:peta,   {1024, 1024}}],

           :meter => [
             {:pico,  {1000, 1000}},
             {:nano,  {1000, 1000}},
             {:micro, {1000, 1000}},
             {:milli, {1000, 10}},
             {:centi, {10, 10}},
             {:deci,  {10, 10}},
             {:one,   {10, 10}},
             {:deca,  {10, 10}},
             {:hecto, {10, 10}},
             {:kilo,  {10, 1000}},
             {:mega,  {1000, 1000}},
             {:giga,  {1000, 1000}}
           ]
          }

  @doc """
  Creates new unit and uses a single unit of measurement. 

  Example:

      iex> Units.from(1, :meter)
      %{amount: 1, quantity: :meter, unit: :one}
  """
  def from(amount, quantity), do: from(amount, :one, quantity)

  @doc """
  Creates new unit. 

  Example:

      iex> Units.from(2, :kilo, :byte)
      %{amount: 2, quantity: :byte, unit: :kilo}
  """
  def from(amount, unit, quantity) 
      when is_atom(unit) 
      and  is_integer(amount), do: %{amount: amount, unit: unit, quantity: quantity}

  @doc """
  Converts a unit to another and returns a unit. Uses a single unit of measurement.

  Example:

      iex> Units.from(1, :kilo, :meter) |> Units.to(:meter)
      %{amount: 1000, quantity: :meter, unit: :one}
  """
  def to(amount, quantity), do: to(amount, :one, quantity)

  @doc """
  Converts a unit to another and returns a unit.

  Example:

      iex> Units.from(100, :deci, :meter) |> Units.to(:centi, :meter)
      %{amount: 1000, quantity: :meter, unit: :centi}
  """
  def to(%{amount: amount, unit: src_unit, quantity: src_quantity}, dst_unit, dst_quantity) 
      when is_integer(amount) 
      and  is_atom(src_unit)
      and  is_atom(dst_unit) 
      and  is_atom(dst_quantity) 
      and  src_quantity == dst_quantity do
    index = @index[dst_quantity]
    %{amount: (convert index, amount, unit_index(index, src_unit), unit_index(index, dst_unit)), unit: dst_unit, quantity: dst_quantity}
  end

  @doc """
  Converts a unit to another and returns an integer. Short for to/2 |> int/1
  """
  def to_int(amount, quantity), do: to_int(amount, :one, quantity)

  @doc """
  Converts a unit to another and returns an integer. Short for to/3 |> int/1
  """
  def to_int(amount, dst_unit, quantity), do: to(amount, dst_unit, quantity) |> int

  @doc """
  Converts a unit to another and returns a float. Short for to/2 |> float/1
  """
  def to_float(amount, quantity), do: to_float(amount, :one, quantity)

  @doc """
  Converts a unit to another and returns a float. Short for to/3 |> float/1
  """
  def to_float(amount, dst_unit, quantity), do: to(amount, dst_unit, quantity) |> float

  @doc """
  Converts a unit to a string representation which can be displayed without loss
  of precision. For example, 1024 megabytes will be displayed as "1GB", while 
  1023 megabytes will be displayed as "1024MB".
  """
  def to_string(%{} = tmp) do
    %{amount: amount, unit: unit, quantity: quantity} = tmp
    dst = to(tmp, 
             highest_unit(@index[quantity], amount, unit), 
             quantity)    
    
    %{unit: dst_unit, quantity: dst_quantity} = dst
    dst_amount = int(dst)    
    
    Integer.to_string(dst_amount) <> atom_initial(dst_unit) <> atom_initial(dst_quantity)
  end  

  @doc """
  Returns the amount as an integer
  """
  def int(%{amount: amount}) 
      when is_integer(amount), do: amount

  @doc """
  Returns the amount as an integer
  """
  def int(%{amount: amount}) 
      when is_float(amount),   do: Kernel.trunc amount

  @doc """
  Returns the amount as a float
  """
  def float(%{amount: amount}), do: amount

  @doc """
  Returns the initial character of an atom. For example, the atom :giga
  will return "G" and the atom :byte will return "B".
  """
  defp atom_initial(atom) when is_atom(atom), do: Atom.to_string(atom) |> String.first |> String.upcase

  defp unit_index(index, unit), do: Enum.find_index(index, fn {x, _} -> x == unit end)

  defp highest_unit(index, amount, unit) do
    {next_unit, {step, _}} = Enum.at(index, (unit_index(index, unit) + 1))
    
    case Kernel.rem(amount, step) do
      0 -> highest_unit(index, Kernel.trunc(amount / step), next_unit)
      _ -> unit
    end
  end

  defp convert(index, amount, src, dst) when src < dst do
    {_, {_, step}} = Enum.at(index, src)
    convert index, (amount / step), src + 1, dst
  end

  defp convert(index, amount, src, dst) when src > dst do
    {_, {step, _}} = Enum.at(index, src)
    convert index, (amount * step), src - 1, dst
  end

  defp convert(_, amount, src, dst) when src == dst, do: amount

end
