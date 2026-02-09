extends MazeAlgorithm

class_name AldousMaze

const _directions: Array[Vector2i] = [ Vector2i(0, 2), Vector2i(2, 0), Vector2i(0, -2), Vector2i(-2, 0) ]

func generate() -> Array[int]:
  var unvisited_cnt = int((width - 1) / 2.0) * int((height - 1) / 2.0)

  var pos = Vector2i(1, 1)
  set_cell(pos, 1)
  unvisited_cnt -= 1
  while unvisited_cnt > 0:
    var valid_directions = filter_directions(pos, _directions, func(_p): return true)
    if valid_directions.size() <= 0:
      continue

    var direction = valid_directions[_rng.randi_range(0, valid_directions.size()-1)]
    var wall = pos + (direction / 2)
    
    set_cell(pos, 1)
    pos += direction

    if get_cell(pos):
      continue

    unvisited_cnt -= 1
    set_cell(wall, 1)

  return maze;
