defmodule UnitsTest do
  use ExUnit.Case
  doctest Units

  test "bytes" do
    assert (Units.from(1, :bytes) |> Units.to_int(:bytes)) == 1
    assert (Units.from(1, :kb) |> Units.to_int(:bytes)) == 1024
    assert (Units.from(1, :mb) |> Units.to_int(:bytes)) == (1024 * 1024)
    assert (Units.from(1, :gb) |> Units.to_int(:bytes)) == (1024 * 1024 * 1024)
    assert (Units.from(1, :tb) |> Units.to_int(:bytes)) == (1024 * 1024 * 1024 * 1024)
    assert (Units.from(1, :pb) |> Units.to_int(:bytes)) == (1024 * 1024 * 1024 * 1024 * 1024)

    assert (Units.from(1, :pb) |> Units.to(:bytes) |> Units.to_int(:pb)) == 1
  end

  test "kb" do
    assert (Units.from(1024, :bytes) |> Units.to_int(:kb)) == 1
    assert (Units.from(1, :kb) |> Units.to_int(:kb)) == 1
    assert (Units.from(1, :mb) |> Units.to_int(:kb)) == 1024
    assert (Units.from(1, :gb) |> Units.to_int(:kb)) == (1024 * 1024)
    assert (Units.from(1, :tb) |> Units.to_int(:kb)) == (1024 * 1024 * 1024)
    assert (Units.from(1, :pb) |> Units.to_int(:kb)) == (1024 * 1024 * 1024 * 1024)

    assert (Units.from(1, :pb) |> Units.to(:kb) |> Units.to_int(:pb)) == 1
  end

  test "mb" do
    assert (Units.from(1024 * 1024, :bytes) |> Units.to_int(:mb)) == 1
    assert (Units.from(1024, :kb) |> Units.to_int(:mb)) == 1
    assert (Units.from(1, :mb) |> Units.to_int(:mb)) == 1
    assert (Units.from(1, :gb) |> Units.to_int(:mb)) == 1024
    assert (Units.from(1, :tb) |> Units.to_int(:mb)) == (1024 * 1024)
    assert (Units.from(1, :pb) |> Units.to_int(:mb)) == (1024 * 1024 * 1024)

    assert (Units.from(1, :pb) |> Units.to(:mb) |> Units.to_int(:pb)) == 1
  end

  test "gb" do
    assert (Units.from(1024 * 1024 * 1024, :bytes) |> Units.to_int(:gb)) == 1
    assert (Units.from(1024 * 1024, :kb) |> Units.to_int(:gb)) == 1
    assert (Units.from(1024, :mb) |> Units.to_int(:gb)) == 1
    assert (Units.from(1, :gb) |> Units.to_int(:gb)) == 1
    assert (Units.from(1, :tb) |> Units.to_int(:gb)) == 1024
    assert (Units.from(1, :pb) |> Units.to_int(:gb)) == (1024 * 1024)

    assert (Units.from(1, :pb) |> Units.to(:gb) |> Units.to_int(:pb)) == 1
  end

  test "tb" do
    assert (Units.from(1024 * 1024 * 1024 * 1024, :bytes) |> Units.to_int(:tb)) == 1
    assert (Units.from(1024 * 1024 * 1024, :kb) |> Units.to_int(:tb)) == 1
    assert (Units.from(1024 * 1024, :mb) |> Units.to_int(:tb)) == 1
    assert (Units.from(1024, :gb) |> Units.to_int(:tb)) == 1
    assert (Units.from(1, :tb) |> Units.to_int(:tb)) == 1
    assert (Units.from(1, :pb) |> Units.to_int(:tb)) == (1024)

    assert (Units.from(1, :pb) |> Units.to(:tb) |> Units.to_int(:pb)) == 1
  end

  test "pb" do
    assert (Units.from(1024 * 1024 * 1024 * 1024 * 1024, :bytes) |> Units.to_int(:pb)) == 1
    assert (Units.from(1024 * 1024 * 1024 * 1024, :kb) |> Units.to_int(:pb)) == 1
    assert (Units.from(1024 * 1024 * 1024, :mb) |> Units.to_int(:pb)) == 1
    assert (Units.from(1024 * 1024, :gb) |> Units.to_int(:pb)) == 1
    assert (Units.from(1024, :tb) |> Units.to_int(:pb)) == 1

    assert (Units.from(1, :pb) |> Units.to_int(:pb)) == 1
  end

end
