extends MazeAlgorithm

class_name HuntKillMaze;

var _rng = RandomNumberGenerator.new()
var _maze: Array[int] = []
var _directions: Array[Vector2i] = [ Vector2i(0, 2), Vector2i(2, 0), Vector2i(0, -2), Vector2i(-2, 0) ]

func generate() -> Array[int]:
  _maze.resize(width*height)

  var pos = Vector2i(1, 1)
  _maze[pos.y * width + pos.x] = 1
  for i in range(((width - 1) / 2) * ((height - 1) / 2)):
    var viable_directions = filter_directions(_maze, pos, _directions, func(m, x, y): return !m[y*width + x])
    if viable_directions.size() <= 0:
      pos = hunt()
      if pos == Vector2i(-1, -1):
        return _maze
    else:  
      var direction = viable_directions[_rng.randi_range(0, viable_directions.size()-1)]
      _maze[idx(pos + direction/2)] = 1
      pos += direction

    _maze[idx(pos)] = 1

  return _maze;

func hunt() -> Vector2i:
  for row in range(height-2, 0, -2):
    for col in range(1, width-1, 2):
      var pos = Vector2i(col, row)
      if _maze[idx(pos)]:
        continue

      var viable_directions = filter_directions(_maze, pos, _directions, func(m, x, y): return m[y*width + x])
      if viable_directions.size() > 0:
        var direction = viable_directions[_rng.randi_range(0, viable_directions.size()-1)]
        var wall = pos + (direction / 2)
        _maze[idx(wall)] = 1
        return pos

  return Vector2i(-1, -1)