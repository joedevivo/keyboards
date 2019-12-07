defmodule IrisHelper do
  use OpenSCAD
  alias Keyboards.Switch.Cherry

  def main() do
  plate =
    Cherry.plate(1,2.9)
    |> translate(v: [17, 27.5, 10])

  obj =
    [cube(size: [7, 55.06, 11])
     |> translate(v: [0,0,1.5]),
     plate,
     cube(size: [3, 55.06, 14])
     |> translate(v: [7,0,0]),
     cube(size: [3, 55.06, 14])
     |> translate(v: [25.3,0,0]),
     cube(size: [20.3, 4, 14])
     |> translate(v: [7,0,0]),
     cube(size: [20.3, 4, 14])
     |> translate(v: [7, 51.06,0]),
     cube(size: [20.3, 55.06, 4])
     |> translate(v: [7,0,0]),
    ] |> union()

  obj
  |> translate(v: [-3,0,0])
  |> difference([
    cube(size: [10,5,5])
    |> translate(v: [0, 25, 3]),
    cube(size: [10, 100, 100])
    |> translate(v: [-10, -1, 0]),
    cube(size: [7, 100, 1.5])
    |> translate(v: [0,-1,0]),
    cube(size: [7, 100, 1.5])
    |> translate(v: [0, -1, 12.5]),
    cube(size: [10, 10, 2])
    |> translate(v: [0, 22.5, 12.5]),
    cylinder(d: 3.2, h: 14, _fn: 20)
    |> translate(v: [3.125, 3.925, 0]),
    cylinder(d: 3.2, h: 14, _fn: 20)
    |> translate(v: [3.125, 3.925+50.18-3.2,0])
  ])
  |> write("./output/iris_helper.scad")
  end
end
