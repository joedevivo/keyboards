defmodule DivideCase do
  use OpenSCAD.Model


  screw_hole =
    cylinder(d: 1.85, h: 3.75, '$fn': 20)
    |> translate(z: -2.05)

  screw_support = 
    cylinder(d: 8, h: 1, '$fn': 20)
    |> difference(screw_hole)

  rgb_strip = 
    cube(x: 85, y: 12, z: 10)
    |> translate(z: 0, x: (112-85)/2 - 2, y: 37)

  divide_pcb =
    [
      # Bottom Left Hole
      screw_hole
      |> translate(x: 18.075, y: 16.775),
      # Bottom Right Hole
      screw_hole
      |> translate(x: 112.01-(16.67+1.075), y: 16.775),
      # Top Right Hole
      screw_hole
      |> translate(x: 112.01-(16.67+1.075), y: 51.59+1.075),
      # Top Left Hole
      screw_hole
      |> translate(x: 13.57+1.075, y: 70.29+1.075),
      # This is the bit that actually represents the PCB
      cube(x: 112.01 + 2, y: 100, z: 100)
      |> translate(z: 1, x: -1),
      # Ceiling, nothing higher than this
      cube(x: 112.01 + 30, y: 100, z: 100)
      |> translate(z: 4, x: -8),
      # This creates the gap area for pins and things
      cube(x: 109.01, y: (44.41+33.44)+100, z: 11.70)
      |> translate(y: 4, x: 2),
      # Notch in top corner for TRRS jack
      cube(z: 25, y: 7+10, x: 26)
      |> translate(x: (112.01-16), y: (44.41+33.44)-9, z: -10),
    ]
    |> union 
    |> difference([
      # Bottom Left PCB Support
      screw_support
      |> translate(x: 18.075, y: 16.775),
      # Bottom Right PCB Support
      screw_support
      |> translate(x: 112.01-(16.67+1.075), y: 16.775),
      # Top Right PCB Support
      screw_support
      |> translate(x: 112.01-(16.67+1.075), y: 51.59+1.075),
      # Top Left PCB Support
      screw_support
      |> translate(x: 13.57+1.075, y: 70.29+1.075)
    ]) 
    |> translate(z: 4)
  
  # :left or :right
  divide =
    fn side ->
      pro_micro = 
        [cube(x: 17.88+2, y: 33.44+100, z: 8)
        |> translate(x: 19.3, y: 43.5)
        ] ++
        # USB Notch
        if side == :right do 
          [cube(z: 2.5, x: 10, y: 100) |> translate(x: 24.5, z: -2.5, y: 70)]
        else 
          []
        end
        |> translate(x: -1.5) |> union 

      divide_internals =
        [divide_pcb, pro_micro, rgb_strip]
        |> union
        |> rotate(x: 5.147)
        |> translate(z: -2)

      floor = 
        cube(x: 150, y: 150, z: 150) 
        |> translate(z: -150, x: -10, y: -10)

      negative_space =
      [
        divide_internals,
        floor
      ]
      |> translate(x: 7)
      |> union

      plate = 
        cube(x: 112.01 + 14, y: (44.41+33.44), z: 20)

      maybe_flip =
        fn x ->
          if side == :right do
            mirror(x, x: 1)
          else
            x
          end
        end

      plate
      |> difference(negative_space)
      |> maybe_flip.()
    end
  
    divide.(:left)
    |> write("./output/divide_case_left.scad")

    divide.(:right)
    |> write("./output/divide_case_right.scad")

end
