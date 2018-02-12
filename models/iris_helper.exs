defmodule IrisHelper do
  use OpenSCAD.Model
  alias Keyboards.Switch.Cherry

  plate =
    Cherry.plate(1,2.9)
    |> translate(x: 17, y: 27.5, z: 10)

  obj = 
    [cube(x: 7, y: 55.06, z: 11)
     |> translate(z: 1.5),
     plate,
     cube(x: 3, y: 55.06, z: 14)
     |> translate(x: 7),
     cube(x: 3, y: 55.06, z: 14)
     |> translate(x: 25.3),
     cube(x: 20.3, y: 4, z: 14)
     |> translate(x: 7),
     cube(x: 20.3, y: 4, z: 14)
     |> translate(x: 7, y: 51.06),
     cube(x: 20.3, y: 55.06, z: 4)
     |> translate(x: 7),
    ] |> union

  obj
  |> translate(x: -3)
  |> difference([
    cube(z: 5, y: 5, x: 10)
    |> translate(z: 3, y: 25),
    cube(x: 10, y: 100, z: 100)
    |> translate(x: -10, y: -1),
    cube(x: 7, z: 1.5, y: 100)
    |> translate(y: -1),
    cube(x: 7, z: 1.5, y: 100)
    |> translate(y: -1, z: 12.5),
    cube(x: 10, z: 2, y: 10)
    |> translate(z: 12.5, y: 22.5),
    cylinder(d: 3.2, h: 14, '$fn': 20)
    |> translate(x: 3.125, y: 3.925),
    cylinder(d: 3.2, h: 14, '$fn': 20)
    |> translate(x: 3.125, y: 3.925+50.18-3.2)
  ])
  |> write("./output/iris_helper.scad")
end