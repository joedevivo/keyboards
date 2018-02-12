defmodule Keyboards.Switch.Cherry do
  import OpenSCAD

  ## Square Dimensions of a Cherry MX compatible switch
  @keyswitch_width 14.4
  @keyswitch_depth 14.4

  ## how wide/deep the walls are around the switch
  @border 3

  @y_translate (@border/2)+(@keyswitch_depth/2)
  @x_translate (@border/2)+(@keyswitch_width/2)


  def plate(width_u \\ 1, depth_u \\ 1, height_mm \\ 4) do
    union([ 
      mount(height_mm),
      difference([
        ## Solid Plate
        cube(x: uToMillis(width_u), y: uToMillis(depth_u), z: height_mm, center: true),
        cube(x: @keyswitch_width+@border*2, y: @keyswitch_depth+@border*2, z: height_mm, center: true)
      ]) |> translate(z: height_mm/2)
    ])
  end

  def mount(height_mm \\ 4) do
    plate_width = @keyswitch_width + @border*2
    plate_depth = @keyswitch_depth + @border*2
    plate_height = height_mm
    ## Top Wall
    top_wall = 
      cube(x: plate_width, y: @border, z: plate_height, center: true)
      |> translate(x: 0, y: @y_translate, z: (plate_height/2))

    ## Bottom Wall
    bottom_wall =
      cube(x: plate_width, y: @border, z: plate_height, center: true)
      |> translate(x: 0, y: -@y_translate, z: (plate_height/2))

    ## Right Wall
    right_wall =
      cube(x: @border, y: plate_depth, z: plate_height, center: true)
      |> translate(x: @x_translate, y: 0, z: (plate_height/2))

    right_nub =
      [
        cube(x: 1.5, y: 2.75, z: plate_height, center: true)
        |> translate(x: 7.95, y: 0, z: plate_height/2),
        cylinder('$fn': 30, h: 2.75, r: 1, center: true)
        |> rotate(x: 90)
        |> translate(x: 7.2, y: 0, z: 1)
      ] |> hull
    
    ## Left Wall
    left_wall =
      cube(x: @border, y: plate_depth, z: plate_height, center: true)
      |> translate(x: -@x_translate, y: 0, z: (plate_height/2))

    left_nub =
      [
        cube(x: 1.5, y: 2.75, z: plate_height, center: true)
        |> translate(x: -7.95, y: 0, z: plate_height/2),
        cylinder('$fn': 30, h: 2.75, r: 1, center: true)
        |> rotate(x: 90)
        |> translate(x: -7.2, y: 0, z: 1)
      ] |> hull
    
    [top_wall, bottom_wall, left_wall, left_nub, right_wall, right_nub]
    |> union

  end

  def uToMillis(u) do
    (18 * (u-1)) + 20.4
  end

end