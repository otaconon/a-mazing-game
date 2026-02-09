extends MazeAlgorithm

class_name AldousMaze

func generate() -> Array[int]:
  var rng = RandomNumberGenerator.new()
  var maze: Array[int] = []
  maze.resize(width*height)
  var directions: Array[Vector2i] = [ Vector2i(0, 2), Vector2i(2, 0), Vector2i(0, -2), Vector2i(-2, 0) ]
  var unvisited_cnt = ((width - 1) / 2) * ((height - 1) / 2)

  var pos = Vector2i(1, 1)
  maze[idx(pos)] = 1
  unvisited_cnt -= 1
  while unvisited_cnt > 0:
    var neighbors = filter_directions(maze, pos, directions, func(_m, _x, _y): return true)
    if neighbors.size() <= 0:
      continue

    var direction = neighbors[rng.randi_range(0, neighbors.size()-1)]
    var wall = pos + (direction / 2)
    
    maze[pos.y * width + pos.x] = 1
    pos += direction

    if maze[pos.y * width + pos.x] != 0:
      continue

    unvisited_cnt -= 1
    maze[wall.y * width + wall.x] = 1

  return maze;
