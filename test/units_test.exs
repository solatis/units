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
    assert (Units.from(1, :peta, :byte) |> Units.to(:peta, :byte) |> Units.int)                  == 1
  end

  test "meters" do
    # Millimeter
    assert (Units.from(1000000000000, :pico,  :meter) |> Units.to_int(:milli, :meter)) == 1000
    assert (Units.from(1000000000,    :nano,  :meter) |> Units.to_int(:milli, :meter)) == 1000
    assert (Units.from(1000000,       :micro, :meter) |> Units.to_int(:milli, :meter)) == 1000
    assert (Units.from(1000,          :milli, :meter) |> Units.to_int(:milli, :meter)) == 1000
    assert (Units.from(100,           :centi, :meter) |> Units.to_int(:milli, :meter)) == 1000
    assert (Units.from(10,            :deci,  :meter) |> Units.to_int(:milli, :meter)) == 1000
    assert (Units.from(1,             :meter)         |> Units.to_int(:milli, :meter)) == 1000

    # Centimeter
    assert (Units.from(1000000000000, :pico,  :meter) |> Units.to_int(:centi, :meter)) == 100
    assert (Units.from(1000000000,    :nano,  :meter) |> Units.to_int(:centi, :meter)) == 100
    assert (Units.from(1000000,       :micro, :meter) |> Units.to_int(:centi, :meter)) == 100
    assert (Units.from(1000,          :milli, :meter) |> Units.to_int(:centi, :meter)) == 100
    assert (Units.from(100,           :centi, :meter) |> Units.to_int(:centi, :meter)) == 100
    assert (Units.from(10,            :deci,  :meter) |> Units.to_int(:centi, :meter)) == 100
    assert (Units.from(1,             :meter)         |> Units.to_int(:centi, :meter)) == 100

    # Decimeter
    assert (Units.from(1000000000000, :pico,  :meter) |> Units.to_int(:deci, :meter)) == 10
    assert (Units.from(1000000000,    :nano,  :meter) |> Units.to_int(:deci, :meter)) == 10
    assert (Units.from(1000000,       :micro, :meter) |> Units.to_int(:deci, :meter)) == 10
    assert (Units.from(1000,          :milli, :meter) |> Units.to_int(:deci, :meter)) == 10
    assert (Units.from(100,           :centi, :meter) |> Units.to_int(:deci, :meter)) == 10
    assert (Units.from(10,            :deci,  :meter) |> Units.to_int(:deci, :meter)) == 10
    assert (Units.from(1,             :meter)         |> Units.to_int(:deci, :meter)) == 10

    # Meter
    assert (Units.from(1000000000000, :pico,  :meter) |> Units.to_int(:meter)) == 1
    assert (Units.from(1000000000,    :nano,  :meter) |> Units.to_int(:meter)) == 1
    assert (Units.from(1000000,       :micro, :meter) |> Units.to_int(:meter)) == 1
    assert (Units.from(1000,          :milli, :meter) |> Units.to_int(:meter)) == 1
    assert (Units.from(100,           :centi, :meter) |> Units.to_int(:meter)) == 1
    assert (Units.from(10,            :deci,  :meter) |> Units.to_int(:meter)) == 1
    assert (Units.from(1,             :meter)         |> Units.to_int(:meter)) == 1

    # Decameter
    assert (Units.from(10000000000000, :pico,  :meter) |> Units.to_int(:deca, :meter)) == 1
    assert (Units.from(10000000000,    :nano,  :meter) |> Units.to_int(:deca, :meter)) == 1
    assert (Units.from(10000000,       :micro, :meter) |> Units.to_int(:deca, :meter)) == 1
    assert (Units.from(10000,          :milli, :meter) |> Units.to_int(:deca, :meter)) == 1
    assert (Units.from(1000,           :centi, :meter) |> Units.to_int(:deca, :meter)) == 1
    assert (Units.from(100,            :deci,  :meter) |> Units.to_int(:deca, :meter)) == 1
    assert (Units.from(10,             :meter)         |> Units.to_int(:deca, :meter)) == 1
    assert (Units.from(1,              :deca,  :meter) |> Units.to_int(:deca, :meter)) == 1

    # Hectometer
    assert (Units.from(100000000000000, :pico,  :meter) |> Units.to_int(:hecto, :meter)) == 1
    assert (Units.from(100000000000,    :nano,  :meter) |> Units.to_int(:hecto, :meter)) == 1
    assert (Units.from(100000000,       :micro, :meter) |> Units.to_int(:hecto, :meter)) == 1
    assert (Units.from(100000,          :milli, :meter) |> Units.to_int(:hecto, :meter)) == 1
    assert (Units.from(10000,           :centi, :meter) |> Units.to_int(:hecto, :meter)) == 1
    assert (Units.from(1000,            :deci,  :meter) |> Units.to_int(:hecto, :meter)) == 1
    assert (Units.from(100,             :meter)         |> Units.to_int(:hecto, :meter)) == 1
    assert (Units.from(10,              :deca,  :meter) |> Units.to_int(:hecto, :meter)) == 1
    assert (Units.from(1,               :hecto, :meter) |> Units.to_int(:hecto, :meter)) == 1
    assert (Units.from(1,               :kilo,  :meter) |> Units.to_int(:hecto, :meter)) == 10
    assert (Units.from(1,               :mega,  :meter) |> Units.to_int(:hecto, :meter)) == 10000

    # Kilometer
    assert (Units.from(1000000000000000, :pico,  :meter) |> Units.to_int(:kilo, :meter)) == 1
    assert (Units.from(1000000000000,    :nano,  :meter) |> Units.to_int(:kilo, :meter)) == 1
    assert (Units.from(1000000000,       :micro, :meter) |> Units.to_int(:kilo, :meter)) == 1
    assert (Units.from(1000000,          :milli, :meter) |> Units.to_int(:kilo, :meter)) == 1
    assert (Units.from(100000,           :centi, :meter) |> Units.to_int(:kilo, :meter)) == 1
    assert (Units.from(10000,            :deci,  :meter) |> Units.to_int(:kilo, :meter)) == 1
    assert (Units.from(1000,             :meter)         |> Units.to_int(:kilo, :meter)) == 1
    assert (Units.from(100,              :deca,  :meter) |> Units.to_int(:kilo, :meter)) == 1
    assert (Units.from(10,               :hecto, :meter) |> Units.to_int(:kilo, :meter)) == 1
    assert (Units.from(1,                :kilo,  :meter) |> Units.to_int(:kilo, :meter)) == 1
    assert (Units.from(1,                :mega,  :meter) |> Units.to_int(:kilo, :meter)) == 1000

    # Megameter
    assert (Units.from(1000000000000000000, :pico,  :meter) |> Units.to_int(:mega, :meter)) == 1
    assert (Units.from(1000000000000000,    :nano,  :meter) |> Units.to_int(:mega, :meter)) == 1
    assert (Units.from(1000000000000,       :micro, :meter) |> Units.to_int(:mega, :meter)) == 1
    assert (Units.from(1000000000,          :milli, :meter) |> Units.to_int(:mega, :meter)) == 1
    assert (Units.from(100000000,           :centi, :meter) |> Units.to_int(:mega, :meter)) == 1
    assert (Units.from(10000000,            :deci,  :meter) |> Units.to_int(:mega, :meter)) == 1
    assert (Units.from(1000000,             :meter)         |> Units.to_int(:mega, :meter)) == 1
    assert (Units.from(100000,              :deca,  :meter) |> Units.to_int(:mega, :meter)) == 1
    assert (Units.from(10000,               :hecto, :meter) |> Units.to_int(:mega, :meter)) == 1
    assert (Units.from(1000,                :kilo,  :meter) |> Units.to_int(:mega, :meter)) == 1
    assert (Units.from(1,                   :mega,  :meter) |> Units.to_int(:mega, :meter)) == 1
    assert (Units.from(1,                   :giga,  :meter) |> Units.to_int(:mega, :meter)) == 1000

    # Gigameter
    assert (Units.from(1000000000000000000000, :pico,  :meter) |> Units.to_int(:giga, :meter)) == 1
    assert (Units.from(1000000000000000000,    :nano,  :meter) |> Units.to_int(:giga, :meter)) == 1
    assert (Units.from(1000000000000000,       :micro, :meter) |> Units.to_int(:giga, :meter)) == 1
    assert (Units.from(1000000000000,          :milli, :meter) |> Units.to_int(:giga, :meter)) == 1
    assert (Units.from(100000000000,           :centi, :meter) |> Units.to_int(:giga, :meter)) == 1
    assert (Units.from(10000000000,            :deci,  :meter) |> Units.to_int(:giga, :meter)) == 1
    assert (Units.from(1000000000,             :meter)         |> Units.to_int(:giga, :meter)) == 1
    assert (Units.from(100000000,              :deca,  :meter) |> Units.to_int(:giga, :meter)) == 1
    assert (Units.from(10000000,               :hecto, :meter) |> Units.to_int(:giga, :meter)) == 1
    assert (Units.from(1000000,                :kilo,  :meter) |> Units.to_int(:giga, :meter)) == 1
    assert (Units.from(1000,                   :mega,  :meter) |> Units.to_int(:giga, :meter)) == 1
    assert (Units.from(1,                      :giga,  :meter) |> Units.to_int(:giga, :meter)) == 1

  end
end
