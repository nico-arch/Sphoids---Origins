extends Spatial

var time := 0.0
#the frame counter is set up so that the meshes update only 
#once every frame_max physics frames. This has a non-negligble 
#effect on performance with few apparent issues. 
var frame_counter := 1
var frame_max := 3

var vertex_count := 0

var wave_length := 0.25

var rng = RandomNumberGenerator.new()
onready var marble = preload("res://To be not buildin/Scenes/marble_rigidbody.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	yield(get_tree().create_timer(8.0), "timeout")
	add_bodies(256)
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	time += delta
	
	#update onscreen debug info
	$Control/Label.text = "FPS: " + String(Engine.get_frames_per_second())
	$Control/Label.text = "FPS: " + String(Engine.get_frames_per_second())
	$Control/Label2.text = "VERTEX COUNT: " + String(vertex_count)
	#$cam_spatial.rotate_y(.001)
	
	if(frame_counter == frame_max):
		arraymesh_update(delta)
		#mesh_tools_update(delta)
		frame_counter = 1
	else:
		frame_counter +=1 

func arraymesh_update(delta : float) -> void:
	#gets the MeshArray arrays for the only surface on the ground mesh
	var mesh_array = $ground.mesh.surface_get_arrays(0)
	#vertex array is at index 0
	var va = mesh_array[0]
	#vertex count is just to update on screen debug info
	vertex_count = va.size()
	
	#change mesh vertices as you see fit, the equation below is just
	#a circular wave function
	for i in range(vertex_count):
		var v = va[i]
		v.y = sin(wave_length*(sqrt((v.x*v.x) + (v.z*v.z))) + time*3) * 4
		va.set(i, v)
	#replace old vertex array with modified vertex array
	mesh_array[0] = va
	var array_mesh = ArrayMesh.new()
	
	array_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, mesh_array)
	#set the ground MeshInstance mesh to the ArrayMesh with the modified
	#vertex mesh.
	$ground.mesh = array_mesh
	#once the mesh is set, create and assign the matching collision shape
	var col_shape = ConcavePolygonShape.new()
	col_shape.set_faces($ground.mesh.get_faces())
	$ground/StaticBody/CollisionShape.set_shape(col_shape)
	$ground/StaticBody/CollisionShape.visible = true


func add_bodies(count: int) -> void:
	var position = global_transform.origin
	for i in count:
		var m = marble.instance()
		var field_size := Vector3(50, 1, 50)
		var x = rng.randi_range(-field_size.x, field_size.x)
		var y = rng.randi_range(40, 60)
		var z = rng.randi_range(-field_size.z, field_size.z)
		m.set_translation(Vector3(x, y, z))
		m.rotate_y(rng.randi_range(0, PI))
		m.rotate_z(rng.randi_range(0, PI))
		add_child(m)
