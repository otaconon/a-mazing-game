extends MazeAlgorithm

class_name DfsMaze

const _directions: Array[Vector2i] = [Vector2i(0, 2), Vector2i(2, 0), Vector2i(0, -2), Vector2i(-2, 0)]

func generate() -> Array[int]:
  var stack: Array[Vector2i] = []
  var pos = Vector2i(1, 1)

  set_cell(pos, 1) 
  stack.push_back(pos)
  while stack.size() > 0:
    pos = stack.back()
    var neighbors = filter_directions(pos, _directions, func(p): return !get_cell(p))

    if neighbors.size() > 0:
      var direction = neighbors[_rng.randi_range(0, neighbors.size()-1)]
      var next_cell = pos + direction
      var wall = pos + (direction / 2)

      set_cell(next_cell, 1)
      set_cell(wall, 1)

      stack.push_back(next_cell)
    else:
      stack.pop_back()

  return maze
