extends Resource

class_name MazeAlgorithm

var width: int
var height: int

func _init(p_width: int, p_height: int) -> void:
  width = p_width
  height = p_height

func get_neighbors(maze: Array[int], position: Vector2i, directions: Array[Vector2i], check: Callable) -> Array[Vector2i]:
  var neighbors: Array[Vector2i]
  for dir in directions:
    var neighbor = position + dir;
    if neighbor.x > 0 and neighbor.x < width - 1 and neighbor.y > 0 and neighbor.y < height - 1 and check.call(maze, neighbor.x, neighbor.y):
      neighbors.push_back(dir);
  return neighbors

func generate() -> Array[int]:
  return []