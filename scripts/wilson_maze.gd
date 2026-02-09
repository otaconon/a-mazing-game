extends MazeAlgorithm

class_name WilsonMaze

func generate() -> Array[int]:
  var rng = RandomNumberGenerator.new()
  var maze: Array[int] = []
  maze.resize(width*height)
  var directions: Array[Vector2i] = [ Vector2i(0, 2), Vector2i(2, 0), Vector2i(0, -2), Vector2i(-2, 0) ]
  var unvisited: Dictionary = {}
  for x in range(1, width, 2):
    for y in range(1, height, 2):
      unvisited[Vector2i(x, y)] = true

  var start_node = unvisited.keys().pick_random()
  unvisited.erase(start_node)
  maze[start_node.y * width + start_node.x] = 1

  while unvisited.size() > 0:
    var pos = unvisited.keys().pick_random()
    var path: Array[Vector2i] = [pos]

    while unvisited.has(pos):
      var neighbors = filter_directions(maze, pos, directions, func(_m, _x, _y): return true)
      if neighbors.size() <= 0:
        continue

      var direction = neighbors[rng.randi_range(0, neighbors.size()-1)]
      pos += direction
      var path_idx = path.find(pos)
      if path_idx != -1:
        path = path.slice(0, path_idx+1)
      else:
        path.push_back(pos)

    for i in range(1, path.size()):
      var wall = path[i-1] + (path[i] - path[i-1])/2
      maze[path[i-1].y * width + path[i-1].x] = 1
      maze[wall.y * width + wall.x] = 1
    maze[path[-1].y * width + path[-1].x] = 1

    for p in path:
      unvisited.erase(p)

  return maze;

