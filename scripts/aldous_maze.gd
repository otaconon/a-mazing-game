extends MazeAlgorithm

class_name AldousMaze

func generate() -> Array[int]:
  var rng = RandomNumberGenerator.new()
  var maze: Array[int] = []
  maze.resize(width*height)
  var start = Vector2i(1, 1)
  var directions: Array[Vector2i] = [ Vector2i(0, 2), Vector2i(2, 0), Vector2i(0, -2), Vector2i(-2, 0) ]
  var unvisited = int(width * height / 4)
  var safetyCount = 0

  var position = start;
  while unvisited > 0 && safetyCount < 100000:
    safetyCount += 1

    var neighbors = get_neighbors(maze, position, directions, func(_m, _x, _y): return true)
    if neighbors.size() <= 0:
      continue

    var direction = neighbors[rng.randi_range(0, neighbors.size()-1)]
    var wall = position + (direction / 2)
    
    maze[position.y * width + position.x] = 1
    position += direction

    if maze[position.y * width + position.x] != 0:
      continue

    unvisited -= 1
    maze[wall.y * width + wall.x] = 1

  return maze;
