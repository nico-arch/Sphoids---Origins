extends KinematicBody
signal seePlayer
signal dontSeePlayer

#export var table : Array
export var n : NodePath
export var is_debud : bool = false
export var speedToGuard : float = 10
export var speedToFollowPlayer : float = 50
export var gravity : float = 0.98
export var mass : float = 5
export var maxVelocity : float = 1
export var distance_to_attack : float = 10
export var offsetToPlayer :float = 5 

export var Player : NodePath

var velocity : Vector3
var y_velocity : float
var target_object_pos : Vector3
var position : Vector3



func _ready():
	pass
var position_counter = 0

func _process(delta):
	
	position = global_transform.origin
	var player = get_node(Player)
	var pos = get_node(n)
	var target_pos = pos.global_transform.origin
	
	#var distance_to_player =  position.distance_to(player.global_transform.origin)
	var distance_to_player =   target_pos.distance_to(player.global_transform.origin)
	
	#print("Distance to player = "+str(distance_to_player))
	
	
	if distance_to_player > distance_to_attack:
		emit_signal("dontSeePlayer")
		#velocity = position.linear_interpolate(target_pos, speedToGuard )
		velocity = position.direction_to(target_pos ) * speedToGuard
		#look_at(Vector3(target_pos.x,0,target_pos.y) , Vector3.UP)
	else:
		emit_signal("seePlayer")
		#velocity = position.linear_interpolate(player.global_transform.origin, speed )
		velocity = position.direction_to( player.global_transform.origin + Vector3(-offsetToPlayer,0,-offsetToPlayer)) * speedToFollowPlayer 
		#look_at(Vector3(player.global_transform.origin.x,0,player.global_transform.origin.y) , Vector3.UP)
	
	if is_on_floor():
		y_velocity = -0.01
	else:
		#y_velocity = -0.01
		y_velocity = clamp(y_velocity - gravity*mass, -maxVelocity, maxVelocity)
		
	velocity.y = y_velocity
	position_counter +=1
	
	velocity = move_and_slide(velocity, Vector3.UP)
	



	"""
	if round(targetPos.x) != round(position.x) or round(targetPos.z) != round(position.z):
		velocity = move_and_slide(velocity, Vector3.UP)
		print("velocity ="+str(velocity)+ " | tar.x = "+str(round(targetPos.x) ) + " | pos.x = "+str(round(position.x)) + " | tar.z = "+str(round(targetPos.z))+" | pos.z = "+str(round(position.z)) + " | tar.y = "+str(round(targetPos.y))+" | pos.y = "+str(round(position.y)) )

	else:
		print("Enemy stoped")
		
	#velocity = position.direction_to( target_pos) * speed #speed
	#velocity = position.direction_to( lerp(po ) target_pos) * speed #speed
	#velocity = lerp(position, target_pos, speed)
	#var targetPos = $"../Position3D".global_transform.origin
	#global_transform.origin = lerp(global_transform.origin, targetPos, delta)
	
	"""
		


