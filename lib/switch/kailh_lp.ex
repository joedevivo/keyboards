defmodule Keyboards.Switch.KailhLP do
  import OpenSCAD

  ## Square Dimensions of a Kailh Ultra low profile switch
  @keyswitch_width 13.8
  @keyswitch_depth 13.8

  ## how wide/deep the walls are around the switch
  @border 3

  @y_translate (@border/2)+(@keyswitch_depth/2)
  @x_translate (@border/2)+(@keyswitch_width/2)


  def plate(width_u \\ 1, depth_u \\ 1, height_mm \\ 3) do
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
    
    ## Left Wall
    left_wall =
      cube(x: @border, y: plate_depth, z: plate_height, center: true)
      |> translate(x: -@x_translate, y: 0, z: (plate_height/2))
    
    [top_wall, bottom_wall, left_wall, right_wall]
    |> union

  end

  def uToMillis(u) do
    (18 * (u-1)) + 20.4
  end

end