defmodule Dactyl do
  @moduledoc """
  Very much inspired by the [Dactyl
  Keyboard](https://github.com/adereth/dactyl-keyboard). This is an attempt to
  provide a complex example for my
  [OpenSCAD](https://github.com/joedevivo/open_scad) library by porting that
  clojure model. I've made personal changes where I saw fit, because I do intend
  to riff on this model after it's ported.

  It's also very much a work in progress

  """
  use OpenSCAD

  # This import due to my aggressive use of module attributes. I need to rethink
  # this as a concept.
  import Keyboards

  # Parameters
  # Math.pi() / 12
  @alpha 15
  # Math.pi() / 36
  @beta 5

  @extra %{
    height: -0.5,
    width: 2.5
  }

  @plate_thickness 4

  @cherry_mx %{
    height: 14.4,
    width: 14.4,
    thickness: 4,
    margin: 3
  }

  @sa %{
    height: 12.7 + @plate_thickness
  }

  @switch @cherry_mx
  @cap @sa

  @mount_height @switch.height + @switch.margin
  @mount_width @switch.width + @switch.margin

  @row_radius (@mount_height + @extra.height) / 2 / sin(@alpha / 2) + @cap.height
  @column_radius (@mount_width + @extra.width) / 2 / sin(@beta / 2) + @cap.height

  @layout [
    [1, 0, 1, 1, 1, 0, 0],
    [1, 1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 1],
    [0, 0, 0, 1, 1, 1, 0]
  ]

  defp layout() do
    center_row =
      @layout
      |> Enum.count()
      |> halvesies()

    center_column =
      @layout
      |> Enum.map(&Enum.count/1)
      |> Enum.sum()
      |> div(Enum.count(@layout))
      |> halvesies()

    @layout
    |> Enum.with_index(-center_row)
    |> Enum.reduce([], fn {row, r}, acc -> acc ++ row_coords(r, center_column, row) end)
  end

  defp halvesies(x) do
    Float.floor(x / 2 - 0.00001)
    |> Kernel.trunc()
  end

  defp row_coords(r, center_col, row) do
    row
    |> Enum.with_index(-center_col)
    |> Enum.reduce(
      [],
      fn
        {0, _}, acc -> acc
        {1, col}, acc -> [{r, col} | acc]
      end
    )
  end

  def sin(x) do
    x
    |> Math.deg2rad()
    |> Math.sin()
  end

  # This one is the dactyl codebase way
  defp single_plate(:cherry) do
    top =
      cube(
        size: [@switch.width + 3, 1.5, @plate_thickness],
        center: true
      )
      |> translate(v: [0, 1.5 / 2 + @cherry_mx.height / 2, @plate_thickness / 2])

    side =
      cube(
        size: [1.5, @cherry_mx.height + 3, @plate_thickness],
        center: true
      )
      |> translate(v: [1.5 / 2 + @cherry_mx.width / 2, 0, @plate_thickness / 2])

    side_nub =
      hull([
        cylinder(h: 1, d: 2.75, center: true, _fn: 30)
        |> rotate(a: 90, v: [1, 0, 0])
        |> translate(v: [@cherry_mx.width / 2, 0, 1]),
        cube(size: [1.5, 2.75, @plate_thickness], center: true)
        |> translate(v: [1.5 / 2 + @cherry_mx.width / 2, 0, @plate_thickness / 2])
      ])

    half = union([top, side, side_nub])

    union([
      mirror(half, v: [1, 0, 0]),
      mirror(half, v: [0, 1, 0])
    ])
  end

  # I'm tracking rows and column ids differently that the original dactyl. 0 ==
  # center, so on the left half d = 0,0

  # +------+------+------+------+------+------+------+
  # |-3,-2 |-2,-2 |-1,-2 | 0,-2 | 1,-2 | 2,-2 | 3,-2 |
  # +------+------+------+------+------+------+------+
  # |-3,-1 |-2,-1 |-1,-1 | 0,-1 | 1,-1 | 2,-1 | 3,-1 |
  # +------+------+------+------+------+------+------+
  # |-3, 0 |-2, 0 |-1, 0 | 0, 0 | 1, 0 | 2, 0 |
  # +------+------+------+------+------+------+
  # |-3, 1 |-2, 1 |-1, 1 | 0, 1 | 1, 1 | 2, 1 |
  # +------+------+------+------+------+------+
  # |-3, 2 |-2, 2 |-1, 2 | 0, 2 | 1, 2 | 2, 2 |
  # +------+------+------+------+------+------+
  defp key_angle(key, col, row) do
    key
    |> translate(v: [0, 0, -@row_radius])
    |> rotate(a: @alpha * -row, v: [1, 0, 0])
    |> translate(v: [0, 0, @row_radius])
    |> translate(v: [0, 0, -@column_radius])
    |> rotate(a: @beta * -col, v: [0, 1, 0])
    |> translate(v: [0, 0, @column_radius])
    |> translate(v: column_offset(col))
  end

  defp column_offset(0), do: [0, 0, 0]
  defp column_offset(index) when index < 0, do: [0, -2.82, 3]
  defp column_offset(ring) when ring == 1, do: [0, -2.82, 3]
  defp column_offset(pinky) when pinky > 1, do: [0, -8.62, 5.64]

  # triangle-hulls is a union of 4 triangles a,b,c b,c,d c,d,a d,a,b
  defp triangle_hulls([first, second | _] = objects) do
    triangle_hulls_(
      objects,
      %{
        first: first,
        second: second,
        hulls: []
      }
    )
  end

  defp triangle_hulls_([last], acc) do
    union([hull([last, acc.first, acc.second]) | acc.hulls])
  end

  defp triangle_hulls_([pen, last], acc) do
    triangle_hulls_(
      [last],
      %{acc | hulls: [hull([pen, last, acc.first]) | acc.hulls]}
    )
  end

  defp triangle_hulls_([a, b, c | _] = objects, acc) do
    triangle_hulls_(
      tl(objects),
      %{acc | hulls: [hull([a, b, c]) | acc.hulls]}
    )
  end

  @post_size 0.1
  @post_adj @post_size / 2
  defp web_post(:tr) do
    web_post()
    |> translate(v: [@mount_width / 2 - @post_adj, @mount_height / 2 - @post_adj, 0])
  end

  defp web_post(:tl) do
    web_post()
    |> translate(v: [@mount_width / -2 + @post_adj, @mount_height / 2 - @post_adj, 0])
  end

  defp web_post(:bl) do
    web_post()
    |> translate(v: [@mount_width / -2 + @post_adj, @mount_height / -2 + @post_adj, 0])
  end

  defp web_post(:br) do
    web_post()
    |> translate(v: [@mount_width / 2 - @post_adj, @mount_height / -2 + @post_adj, 0])
  end

  defp web_post(), do: cube(size: [@post_size, @post_size, 4])

  def row_connector({row, col}) do
    [
      web_post(:br)
      |> key_angle(col, row),
      web_post(:bl)
      |> key_angle(col + 1, row),
      web_post(:tr)
      |> key_angle(col, row),
      web_post(:tl)
      |> key_angle(col + 1, row)
    ]
    |> triangle_hulls()
  end

  def col_connector({row, col}) do
    [
      web_post(:br)
      |> key_angle(col, row),
      web_post(:bl)
      |> key_angle(col, row),
      web_post(:tr)
      |> key_angle(col, row + 1),
      web_post(:tl)
      |> key_angle(col, row + 1)
    ]
    |> triangle_hulls()
  end

  def diagonal_connector({row, col}) do
    [
      web_post(:br)
      |> key_angle(col, row),
      web_post(:bl)
      |> key_angle(col + 1, row),
      web_post(:tr)
      |> key_angle(col, row + 1),
      web_post(:tl)
      |> key_angle(col + 1, row + 1)
    ]
    |> triangle_hulls()
  end

  # TODO: has to be in a function
  def main() do
    l = layout()

    (for {row, col} <- l do
       single_plate(:cherry)
       |> key_angle(col, row)
     end ++
       Enum.reduce(
         l,
         [],
         fn {x, y}, acc ->
           [
             row_connector({x, y}),
             row_connector({x, y - 1}),
             col_connector({x, y}),
             col_connector({x - 1, y}),
             diagonal_connector({x, y}),
             diagonal_connector({x - 1, y}),
             diagonal_connector({x, y - 1}),
             diagonal_connector({x - 1, y - 1})
           ] ++ acc
         end
       ))
    |> union()
    |> write("./output/single_plate.scad")
  end
end
