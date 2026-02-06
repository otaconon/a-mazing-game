extends ImageTexture

class_name MazeTexture

var _img: Image

func _init(maze: Array[int], width: int, height: int):
  _img = Image.create(width, height, false, Image.FORMAT_RGBA8)
  for x in range(width):
    for y in range(height):
      if maze[y * width + x]:
        _img.set_pixel(x, y, Color.BLACK)
      else:
        _img.set_pixel(x, y, Color.WHITE)
              
  set_image(_img)