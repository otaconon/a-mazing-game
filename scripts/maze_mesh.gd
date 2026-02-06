extends ArrayMesh

class_name MazeMesh

var _width: int
var _height: int
var _maze: Array[int]

func _init(maze, width, height):
  _width = width
  _height = height
  _maze = maze

  var st = SurfaceTool.new()
  st.begin(Mesh.PRIMITIVE_TRIANGLES)
  st.set_smooth_group(-1)

  for x in range(width):
    for z in range(height):
      if maze[z*width + x]:
        continue
      var pos = Vector3i(x, 0, z)
      create_block(st, pos)
  st.generate_normals()
  st.generate_tangents()
  st.commit(self)

func create_block(st: SurfaceTool, pos: Vector3i):
  add_face(st, pos+Vector3i.UP, Vector3i.FORWARD, Vector3i.RIGHT, false)
  # Front face
  if is_gap(pos.x, pos.z-1):
    add_face(st, pos+Vector3i.FORWARD, Vector3i.UP, Vector3i.RIGHT, true)

  # Back face
  if is_gap(pos.x, pos.z+1):
    add_face(st, pos, Vector3i.UP, Vector3i.RIGHT, false)

  # Right face
  if is_gap(pos.x+1, pos.z):
    add_face(st, pos+Vector3i.RIGHT, Vector3i.UP, Vector3i.FORWARD, false)

  # Left face 
  if is_gap(pos.x-1, pos.z):
    add_face(st, pos, Vector3i.UP, Vector3i.FORWARD, true)

func is_gap(x: int, z: int) -> bool:
  if x < 0 || x >= _width || z < 0 || z >= _height:
    return true
  return _maze[z*_width + x]


func add_face(st: SurfaceTool, corner: Vector3, up_dir: Vector3, right_dir: Vector3, flip: bool):
  var u = right_dir
  var v = up_dir 

  var vertices = PackedVector3Array([
    corner,             # 0
    corner + v,         # 1
    corner + u + v,     # 2
    corner + u          # 3
  ])
  
  var uvs = PackedVector2Array([
    Vector2(0, 0),
    Vector2(0, 1),
    Vector2(1, 1),
    Vector2(1, 0)
  ])

  if flip:
    vertices.reverse()
    uvs.reverse()

  st.add_triangle_fan(vertices, uvs)