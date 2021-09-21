extends KinematicBody

export var table : Array
#export var navigation : NodePath
export var is_debud : bool = false
export var speed : float = 10
export var gravity : float = 0.98
export var mass : float = 5
export var maxVelocity : float = 1


var velocity : Vector3
var y_velocity : float
var target_object_pos : Vector3

#onready var nav = get_node(navigation)

func _ready():
	pass
var position_counter = 0

func _process(delta):
	#var targetPos = $"../Position3D".global_transform.origin
	#global_transform.origin = lerp(global_transform.origin, targetPos, delta)
	var position = global_transform.origin
	
	
	"""
	var velocity = position.direction_to(targetPos) * speed #speed
	
	if is_on_floor():
		y_velocity = -0.01
	else:
		y_velocity = clamp(y_velocity - gravity*mass, -maxVelocity, maxVelocity)
		
	velocity.y = y_velocity
	"""
	
	
	for n in table:
		var pos = get_node(n)
		var target_pos = pos.global_transform.origin
		velocity = position.direction_to(target_pos) * speed #speed
		if is_on_floor():
			y_velocity = -0.01
		else:
			y_velocity = clamp(y_velocity - gravity*mass, -maxVelocity, maxVelocity)
		
		velocity.y = y_velocity
		position_counter +=1
		#var actual_target = get_node(target_pos)
		
		while round(target_pos.x) != round(position.x) or round(target_pos.z) != round(position.z) :
			velocity = move_and_slide(velocity, Vector3.UP)
			print("velocity ="+str(velocity)+ " | tar.x = "+str(round(target_pos.x) ) + " | pos.x = "+str(round(position.x)) + " | tar.z = "+str(round(target_pos.z))+" | pos.z = "+str(round(position.z)) + " | tar.y = "+str(round(target_pos.y))+" | pos.y = "+str(round(position.y)) )
			break







	"""
	if round(targetPos.x) != round(position.x) or round(targetPos.z) != round(position.z):
		velocity = move_and_slide(velocity, Vector3.UP)
		print("velocity ="+str(velocity)+ " | tar.x = "+str(round(targetPos.x) ) + " | pos.x = "+str(round(position.x)) + " | tar.z = "+str(round(targetPos.z))+" | pos.z = "+str(round(position.z)) + " | tar.y = "+str(round(targetPos.y))+" | pos.y = "+str(round(position.y)) )

	else:
		print("Enemy stoped")
	"""
		


