extends Resource

class_name MazeAlgorithm

var width: int
var height: int
var maze: Array[int]

var _rng: RandomNumberGenerator

func _init(p_width: int, p_height: int) -> void:
  width = p_width
  height = p_height
  maze = []
  maze.resize(width*height)

  _rng = RandomNumberGenerator.new()

func generate() -> Array[int]:
  return []

## Returns directions that dont go out of bounds, and meet the lambda criterion
func filter_directions(position: Vector2i, directions: Array[Vector2i], check: Callable) -> Array[Vector2i]:
  var valid_directions: Array[Vector2i]
  for dir in directions:
    var neighbor = position + dir;
    if neighbor.x > 0 and neighbor.x < width - 1 and neighbor.y > 0 and neighbor.y < height - 1 and check.call(neighbor):
      valid_directions.push_back(dir);
  return valid_directions

func set_cell(position: Vector2i, value: int):
  maze[position.y * width + position.x] = value

func get_cell(position: Vector2i):
  return maze[position.y * width + position.x]