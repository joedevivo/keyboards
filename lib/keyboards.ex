defmodule Keyboards do
  # TODO: This needs to be defined here for use in a model's module attributes.
  # It's not clean, but I haven't decided how I want to improve this yet.
  def sin(x) do
    x
    |> Math.deg2rad()
    |> Math.sin()
  end
end
