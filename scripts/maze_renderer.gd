@tool
extends Node3D

enum MazeAlgorithmType {
  BINARY, DFS, ALDOUS, WILSON, HUNT_AND_KILL
}

@export
var maze_algorithm: MazeAlgorithmType

@export var sprite: Sprite3D
@export var mesh: MeshInstance3D
@export var width: int
@export var height: int

@export_tool_button("generate maze")
var generate_maze = _generate_maze

var _maze: Array[int]

func _generate_maze():
  var generator: MazeAlgorithm
  match maze_algorithm:
    MazeAlgorithmType.BINARY:
      generator = BinaryMaze.new(width, height)
    MazeAlgorithmType.DFS:
      generator = DfsMaze.new(width, height)
    MazeAlgorithmType.ALDOUS:
      generator = AldousMaze.new(width, height)
    MazeAlgorithmType.WILSON:
      generator = WilsonMaze.new(width, height)
    MazeAlgorithmType.HUNT_AND_KILL:
      generator = HuntKillMaze.new(width, height)

  _maze = generator.generate()

  sprite.texture = MazeTexture.new(_maze, width, height)
  sprite.texture_filter = BaseMaterial3D.TEXTURE_FILTER_NEAREST

  mesh.mesh = MazeMesh.new(_maze, width, height)