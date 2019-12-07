defmodule Keyboards.Switch.KailhLP do
  use OpenSCAD

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
        cube(size: [uToMillis(width_u), uToMillis(depth_u), height_mm], center: true),
        cube(size: [@keyswitch_width+@border*2, @keyswitch_depth+@border*2, height_mm], center: true)
      ]) |> translate(v: [0,0,height_mm/2])
    ])
  end

  def mount(height_mm \\ 4) do
    plate_width = @keyswitch_width + @border*2
    plate_depth = @keyswitch_depth + @border*2
    plate_height = height_mm
    ## Top Wall
    top_wall =
      cube(size: [plate_width, @border, plate_height], center: true)
      |> cube(v: [0, @y_translate, (plate_height/2)])

    ## Bottom Wall
    bottom_wall =
      cube(size: [plate_width, @border, plate_height], center: true)
      |> cube(v: [0, -@y_translate, (plate_height/2)])

    ## Right Wall
    right_wall =
      cube(size: [@border, plate_depth, plate_height], center: true)
      |> cube(v: [@x_translate, 0, (plate_height/2)])

    ## Left Wall
    left_wall =
      cube(size: [@border, plate_depth, plate_height], center: true)
      |> cube(v: [-@x_translate, 0, (plate_height/2)])

    [top_wall, bottom_wall, left_wall, right_wall]
    |> union

  end

  def uToMillis(u) do
    (18 * (u-1)) + 20.4
  end

end
