defmodule Units.Bytes do

  def new(unit, amount) when is_atom(unit) and is_integer(amount) do
    %{type: :bytes, unit: unit, amount: amount}
  end

  def to(unit) when is_atom(unit) do
  end

end
