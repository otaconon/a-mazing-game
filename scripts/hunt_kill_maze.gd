extends MazeAlgorithm

class_name HuntKillMaze;

const _directions: Array[Vector2i] = [ Vector2i(0, 2), Vector2i(2, 0), Vector2i(0, -2), Vector2i(-2, 0) ]

func generate() -> Array[int]:
  var pos = Vector2i(1, 1)
  set_cell(pos, 1) 
  for i in range(int((width - 1) / 2.0) * int((height - 1) / 2.0)):
    var valid_directions = filter_directions(pos, _directions, func(p): return !get_cell(p))
    if valid_directions.size() <= 0:
      pos = hunt()
      if pos == Vector2i(-1, -1):
        return maze
    else:  
      var direction = valid_directions[_rng.randi_range(0, valid_directions.size()-1)]
      set_cell(pos + direction/2, 1)
      pos += direction

    set_cell(pos, 1)

  return maze;

func hunt() -> Vector2i:
  for row in range(height-2, 0, -2):
    for col in range(1, width-1, 2):
      var pos = Vector2i(col, row)
      if get_cell(pos):
        continue

      var viable_directions = filter_directions(pos, _directions, func(p): return get_cell(p))
      if viable_directions.size() > 0:
        var direction = viable_directions[_rng.randi_range(0, viable_directions.size()-1)]
        var wall = pos + (direction / 2)
        set_cell(wall, 1)
        return pos

  return Vector2i(-1, -1)