extends MazeAlgorithm

class_name WilsonMaze

const _directions: Array[Vector2i] = [ Vector2i(0, 2), Vector2i(2, 0), Vector2i(0, -2), Vector2i(-2, 0) ]

func generate() -> Array[int]:
  var unvisited: Dictionary = {}
  for x in range(1, width, 2):
    for y in range(1, height, 2):
      unvisited[Vector2i(x, y)] = true

  var start_node = unvisited.keys().pick_random()
  unvisited.erase(start_node)
  set_cell(start_node, 1)

  while unvisited.size() > 0:
    var pos = unvisited.keys().pick_random()
    var path: Array[Vector2i] = [pos]

    while unvisited.has(pos):
      var valid_directions = filter_directions(pos, _directions, func(_v): return true)
      if valid_directions.size() <= 0:
        continue

      var direction = valid_directions[_rng.randi_range(0, valid_directions.size()-1)]
      pos += direction
      var path_idx = path.find(pos)
      if path_idx != -1:
        path = path.slice(0, path_idx+1)
      else:
        path.push_back(pos)

    for i in range(1, path.size()):
      var wall = path[i-1] + (path[i] - path[i-1])/2
      set_cell(path[i-1], 1)
      set_cell(wall, 1)
    set_cell(path[-1], 1)

    for p in path:
      unvisited.erase(p)

  return maze;

