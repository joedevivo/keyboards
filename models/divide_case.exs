defmodule DivideCase do
  use OpenSCAD

  def divide(side) do
  screw_hole =
    cylinder(d: 1.85, h: 3.75, _fn: 20)
    |> translate(v: [0, 0,-2.05])

  screw_support =
    cylinder(d: 8, h: 1, _fn: 20)
    |> difference([screw_hole])

  rgb_strip =
    cube(v: [85, 12, 10])
    |> translate(v: [(112-85)/2 - 2, 37, 0])

  divide_pcb =
    [
      # Bottom Left Hole
      screw_hole
      |> translate(v: [18.075, 16.775, 0]),
      # Bottom Right Hole
      screw_hole
      |> translate(v: [112.01-(16.67+1.075), 16.775, 0]),
      # Top Right Hole
      screw_hole
      |> translate(v: [112.01-(16.67+1.075), 51.59+1.075, 0]),
      # Top Left Hole
      screw_hole
      |> translate(v: [13.57+1.075, 70.29+1.075, 0]),
      # This is the bit that actually represents the PCB
      cube(size: [112.01 + 2, 100, 100])
      |> translate(v: [-1, 0, 1]),
      # Ceiling, nothing higher than this
      cube(size: [112.01 + 30, 100, 100])
      |> translate(v: [-8, 0, 4]),
      # This creates the gap area for pins and things
      cube(size: [109.01, (44.41+33.44)+100, 11.70])
      |> translate(v: [2, 4, 0]),
      # Notch in top corner for TRRS jack
      cube(size: [26, 7+10, 25])
      |> translate(v: [(112.01-16), (44.41+33.44)-9, -10]),
    ]
    |> union
    |> difference([
      # Bottom Left PCB Support
      screw_support
      |> translate(v: [18.075, 16.775, 0]),
      # Bottom Right PCB Support
      screw_support
      |> translate(v: [112.01-(16.67+1.075), 16.775, 0]),
      # Top Right PCB Support
      screw_support
      |> translate(v: [112.01-(16.67+1.075), 51.59+1.075, 0]),
      # Top Left PCB Support
      screw_support
      |> translate(v: [13.57+1.075, 70.29+1.075, 0])
    ])
    |> translate(v: [0,0,4])

  # :left or :right
      pro_micro =
        [cube(size: [17.88+2, 33.44+100, 8])
        |> translate(v: [19.3, 43.5, 0])
        ] ++
        # USB Notch
        if side == :right do
          [cube(size: [10, 100, 2.5]) |> translate(v: [24.5, -2.5, 70])]
        else
          []
        end
        |> translate(v: [-1.5, 0, 0]) |> union

      divide_internals =
        [divide_pcb, pro_micro, rgb_strip]
        |> union()
        |> rotate(a: [5.147,0,0])
        |> translate(v: [0,0,-2])

      floor =
        cube(size: [150, 150, 150])
        |> translate(v: [-10, -10, -150])

      negative_space =
      [
        divide_internals,
        floor
      ]
      |> translate(v: [7,0,0])
      |> union

      plate =
        cube(size: [112.01 + 14, (44.41+33.44), 20])

      maybe_flip =
        fn x ->
          if side == :right do
            mirror(x, v: [1, 0, 0])
          else
            x
          end
        end

      plate
      |> difference(negative_space)
      |> maybe_flip.()
    end

    def main() do
      divide(:left)
      |> write("./output/divide_case_left.scad")

      divide(:right)
      |> write("./output/divide_case_right.scad")
    end
end
