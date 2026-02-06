extends MazeAlgorithm

class_name BinaryMaze

func generate() -> Array[int]:
  var maze: Array[int] = []
  var rng = RandomNumberGenerator.new()
  maze.resize(width * height)
  var directions: Array[Vector2i] = [Vector2i(0, 2), Vector2i(2, 0)]
  for row in range(1, width-1, 2):
    for col in range(1, height-1, 2):
      var position = Vector2i(row, col)
      var neighbors = get_neighbors(maze, Vector2i(row, col), directions, func(m, x, y): return m[y*width + x] == 0)
      maze[position.y * width + position.x] = 1
      if neighbors.size() > 0:
        var direction = neighbors[rng.randi_range(0, neighbors.size()-1)]
        var wall = position + (direction / 2)
        maze[wall.y * width + wall.x] = 1

  print("generated maze")
  return maze
