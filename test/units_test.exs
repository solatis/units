defmodule UnitsTest do
  use ExUnit.Case
  doctest Units

  test "bytes" do
    # Regular bytes
    assert (Units.from(1, :bytes)        |> Units.to_int(:bytes)) == 1
    assert (Units.from(1, :kilo, :bytes) |> Units.to_int(:bytes)) == 1024
    assert (Units.from(1, :mega, :bytes) |> Units.to_int(:bytes)) == (1024 * 1024)
    assert (Units.from(1, :giga, :bytes) |> Units.to_int(:bytes)) == (1024 * 1024 * 1024)
    assert (Units.from(1, :tera, :bytes) |> Units.to_int(:bytes)) == (1024 * 1024 * 1024 * 1024)
    assert (Units.from(1, :peta, :bytes) |> Units.to_int(:bytes)) == (1024 * 1024 * 1024 * 1024 * 1024)

    # Kilobytes 
    assert (Units.from(1024, :bytes)        |> Units.to_int(:kilo, :bytes)) == 1
    assert (Units.from(1,    :kilo, :bytes) |> Units.to_int(:kilo, :bytes)) == 1
    assert (Units.from(1,    :mega, :bytes) |> Units.to_int(:kilo, :bytes)) == 1024
    assert (Units.from(1,    :giga, :bytes) |> Units.to_int(:kilo, :bytes)) == (1024 * 1024)
    assert (Units.from(1,    :tera, :bytes) |> Units.to_int(:kilo, :bytes)) == (1024 * 1024 * 1024)
    assert (Units.from(1,    :peta, :bytes) |> Units.to_int(:kilo, :bytes)) == (1024 * 1024 * 1024 * 1024)

    # Megabytes
    assert (Units.from(1024 * 1024, :bytes)        |> Units.to_int(:mega, :bytes)) == 1
    assert (Units.from(1024,        :kilo, :bytes) |> Units.to_int(:mega, :bytes)) == 1
    assert (Units.from(1,           :mega, :bytes) |> Units.to_int(:mega, :bytes)) == 1
    assert (Units.from(1,           :giga, :bytes) |> Units.to_int(:mega, :bytes)) == 1024
    assert (Units.from(1,           :tera, :bytes) |> Units.to_int(:mega, :bytes)) == (1024 * 1024)
    assert (Units.from(1,           :peta, :bytes) |> Units.to_int(:mega, :bytes)) == (1024 * 1024 * 1024)

    # Gigabytes
    assert (Units.from(1024 * 1024 * 1024, :bytes)        |> Units.to_int(:giga, :bytes)) == 1
    assert (Units.from(1024 * 1024,        :kilo, :bytes) |> Units.to_int(:giga, :bytes)) == 1
    assert (Units.from(1024,               :mega, :bytes) |> Units.to_int(:giga, :bytes)) == 1
    assert (Units.from(1,                  :giga, :bytes) |> Units.to_int(:giga, :bytes)) == 1
    assert (Units.from(1,                  :tera, :bytes) |> Units.to_int(:giga, :bytes)) == 1024
    assert (Units.from(1,                  :peta, :bytes) |> Units.to_int(:giga, :bytes)) == (1024 * 1024)

    # Terabytes
    assert (Units.from(1024 * 1024 * 1024 * 1024, :bytes)        |> Units.to_int(:tera, :bytes)) == 1
    assert (Units.from(1024 * 1024 * 1024,        :kilo, :bytes) |> Units.to_int(:tera, :bytes)) == 1
    assert (Units.from(1024 * 1024,               :mega, :bytes) |> Units.to_int(:tera, :bytes)) == 1
    assert (Units.from(1024,                      :giga, :bytes) |> Units.to_int(:tera, :bytes)) == 1
    assert (Units.from(1,                         :tera, :bytes) |> Units.to_int(:tera, :bytes)) == 1
    assert (Units.from(1,                         :peta, :bytes) |> Units.to_int(:tera, :bytes)) == (1024)

    # Petabytes
    assert (Units.from(1024 * 1024 * 1024 * 1024 * 1024, :bytes)        |> Units.to_int(:peta, :bytes)) == 1
    assert (Units.from(1024 * 1024 * 1024 * 1024,        :kilo, :bytes) |> Units.to_int(:peta, :bytes)) == 1
    assert (Units.from(1024 * 1024 * 1024,               :mega, :bytes) |> Units.to_int(:peta, :bytes)) == 1
    assert (Units.from(1024 * 1024,                      :giga, :bytes) |> Units.to_int(:peta, :bytes)) == 1
    assert (Units.from(1024,                             :tera, :bytes) |> Units.to_int(:peta, :bytes)) == 1

    # Some tests that convert from petabyte to unit and back
    assert (Units.from(1, :peta, :bytes) |> Units.to(:bytes)        |> Units.to_int(:peta, :bytes)) == 1
    assert (Units.from(1, :peta, :bytes) |> Units.to(:kilo, :bytes) |> Units.to_int(:peta, :bytes)) == 1
    assert (Units.from(1, :peta, :bytes) |> Units.to(:mega, :bytes) |> Units.to_int(:peta, :bytes)) == 1
    assert (Units.from(1, :peta, :bytes) |> Units.to(:giga, :bytes) |> Units.to_int(:peta, :bytes)) == 1
    assert (Units.from(1, :peta, :bytes) |> Units.to(:tera, :bytes) |> Units.to_int(:peta, :bytes)) == 1
    assert (Units.from(1, :peta, :bytes) |> Units.to(:peta, :bytes) |> Units.int)                   == 1
  end
end
