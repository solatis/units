defmodule UnitsTest do
  use ExUnit.Case
  doctest Units

  test "bytes" do
    # Regular bytes
    assert (Units.from(1, :byte)        |> Units.to_int(:byte)) == 1
    assert (Units.from(1, :kilo, :byte) |> Units.to_int(:byte)) == 1024
    assert (Units.from(1, :mega, :byte) |> Units.to_int(:byte)) == (1024 * 1024)
    assert (Units.from(1, :giga, :byte) |> Units.to_int(:byte)) == (1024 * 1024 * 1024)
    assert (Units.from(1, :tera, :byte) |> Units.to_int(:byte)) == (1024 * 1024 * 1024 * 1024)
    assert (Units.from(1, :peta, :byte) |> Units.to_int(:byte)) == (1024 * 1024 * 1024 * 1024 * 1024)

    # Kilobytes 
    assert (Units.from(1024, :byte)        |> Units.to_int(:kilo, :byte)) == 1
    assert (Units.from(1,    :kilo, :byte) |> Units.to_int(:kilo, :byte)) == 1
    assert (Units.from(1,    :mega, :byte) |> Units.to_int(:kilo, :byte)) == 1024
    assert (Units.from(1,    :giga, :byte) |> Units.to_int(:kilo, :byte)) == (1024 * 1024)
    assert (Units.from(1,    :tera, :byte) |> Units.to_int(:kilo, :byte)) == (1024 * 1024 * 1024)
    assert (Units.from(1,    :peta, :byte) |> Units.to_int(:kilo, :byte)) == (1024 * 1024 * 1024 * 1024)

    # Megabytes
    assert (Units.from(1024 * 1024, :byte)        |> Units.to_int(:mega, :byte)) == 1
    assert (Units.from(1024,        :kilo, :byte) |> Units.to_int(:mega, :byte)) == 1
    assert (Units.from(1,           :mega, :byte) |> Units.to_int(:mega, :byte)) == 1
    assert (Units.from(1,           :giga, :byte) |> Units.to_int(:mega, :byte)) == 1024
    assert (Units.from(1,           :tera, :byte) |> Units.to_int(:mega, :byte)) == (1024 * 1024)
    assert (Units.from(1,           :peta, :byte) |> Units.to_int(:mega, :byte)) == (1024 * 1024 * 1024)

    # Gigabytes
    assert (Units.from(1024 * 1024 * 1024, :byte)        |> Units.to_int(:giga, :byte)) == 1
    assert (Units.from(1024 * 1024,        :kilo, :byte) |> Units.to_int(:giga, :byte)) == 1
    assert (Units.from(1024,               :mega, :byte) |> Units.to_int(:giga, :byte)) == 1
    assert (Units.from(1,                  :giga, :byte) |> Units.to_int(:giga, :byte)) == 1
    assert (Units.from(1,                  :tera, :byte) |> Units.to_int(:giga, :byte)) == 1024
    assert (Units.from(1,                  :peta, :byte) |> Units.to_int(:giga, :byte)) == (1024 * 1024)

    # Terabytes
    assert (Units.from(1024 * 1024 * 1024 * 1024, :byte)        |> Units.to_int(:tera, :byte)) == 1
    assert (Units.from(1024 * 1024 * 1024,        :kilo, :byte) |> Units.to_int(:tera, :byte)) == 1
    assert (Units.from(1024 * 1024,               :mega, :byte) |> Units.to_int(:tera, :byte)) == 1
    assert (Units.from(1024,                      :giga, :byte) |> Units.to_int(:tera, :byte)) == 1
    assert (Units.from(1,                         :tera, :byte) |> Units.to_int(:tera, :byte)) == 1
    assert (Units.from(1,                         :peta, :byte) |> Units.to_int(:tera, :byte)) == (1024)

    # Petabytes
    assert (Units.from(1024 * 1024 * 1024 * 1024 * 1024, :byte)        |> Units.to_int(:peta, :byte)) == 1
    assert (Units.from(1024 * 1024 * 1024 * 1024,        :kilo, :byte) |> Units.to_int(:peta, :byte)) == 1
    assert (Units.from(1024 * 1024 * 1024,               :mega, :byte) |> Units.to_int(:peta, :byte)) == 1
    assert (Units.from(1024 * 1024,                      :giga, :byte) |> Units.to_int(:peta, :byte)) == 1
    assert (Units.from(1024,                             :tera, :byte) |> Units.to_int(:peta, :byte)) == 1

    # Some tests that convert from petabyte to unit and back
    assert (Units.from(1, :peta, :byte) |> Units.to(:byte)        |> Units.to_int(:peta, :byte)) == 1
    assert (Units.from(1, :peta, :byte) |> Units.to(:kilo, :byte) |> Units.to_int(:peta, :byte)) == 1
    assert (Units.from(1, :peta, :byte) |> Units.to(:mega, :byte) |> Units.to_int(:peta, :byte)) == 1
    assert (Units.from(1, :peta, :byte) |> Units.to(:giga, :byte) |> Units.to_int(:peta, :byte)) == 1
    assert (Units.from(1, :peta, :byte) |> Units.to(:tera, :byte) |> Units.to_int(:peta, :byte)) == 1
    assert (Units.from(1, :peta, :byte) |> Units.to(:peta, :byte) |> Units.int)                   == 1
  end
end
