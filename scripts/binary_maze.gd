extends MazeAlgorithm

class_name BinaryMaze

const _directions: Array[Vector2i] = [Vector2i(0, 2), Vector2i(2, 0)]

func generate() -> Array[int]:
  for row in range(1, width-1, 2):
    for col in range(1, height-1, 2):
      var pos = Vector2i(row, col)
      var neighbors = filter_directions(Vector2i(row, col), _directions, func(p): return !get_cell(p))
      set_cell(pos, 1) 
      if neighbors.size() > 0:
        var direction = neighbors[_rng.randi_range(0, neighbors.size()-1)]
        var wall = pos + (direction / 2)
        set_cell(wall, 1) 

  return maze
