extends MazeAlgorithm

class_name DfsMaze

func generate() -> Array[int]:
  var rng = RandomNumberGenerator.new()
  var maze: Array[int] = []
  maze.resize(width*height)

  var stack: Array[Vector2i] = []
  var start = Vector2i(1, 1)
  var directions: Array[Vector2i] = [Vector2i(0, 2), Vector2i(2, 0), Vector2i(0, -2), Vector2i(-2, 0)]

  maze[start.y * width + start.x] = 1
  stack.push_back(start)
  while stack.size() > 0:
    var current = stack.back()
    var neighbors = get_neighbors(maze, current, directions, func(m, x, y): return m[y*width + x] == 0)

    if neighbors.size() > 0:
      var direction = neighbors[rng.randi_range(0, neighbors.size()-1)];
      var nextCell = current + direction;
      var wall = current + (direction / 2);

      maze[nextCell.y*width + nextCell.x] = 1;
      maze[wall.y*width + wall.x] = 1;
      stack.push_back(nextCell);
    else:
      stack.pop_back();

  return maze;
