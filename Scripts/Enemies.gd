extends KinematicBody



export var is_debud: bool = false
export var safe_distance_to_player : Vector3
export var speed : float = 10
export var gravity : float = 0.98
export var maxVelocity : float = 54
export var player : NodePath
export var navigation : NodePath

var path = []
var path_node = 0
var velocity : Vector3
var y_velocity : float
var target_object_pos : Vector3


#onready var playerContainer = $"../../Player"
onready var Player  =  get_node(player)
onready var nav = get_node(navigation)
onready var initial_pos : Vector3 = global_transform.origin


func _process(delta):
	if path_node < path.size():
		var direction = (path[path_node] - global_transform.origin)
		if direction.length() < 1:
			path_node += 1
		else:
			if is_on_floor():
				y_velocity = -0.01
				pass
			else:
				y_velocity = clamp(y_velocity - gravity, -maxVelocity, maxVelocity)
				#y_velocity = -0.01
			direction.y = y_velocity
			
			move_and_slide(direction.normalized() * speed, Vector3.UP)
			


func move_to(target_pos):
	#if overlaps_body(body: Node)
	target_object_pos = target_pos
	path = nav.get_simple_path(global_transform.origin, target_pos)
	path_node = 0
	pass


func _on_Timer_timeout():
	#calculate the distance of the initial postion to player
	var distance_to_player :Vector3 = Player.global_transform.origin - initial_pos
	if is_debud:
		print("Player distance to enemy initial postion :"+str(distance_to_player))
	var xValue = abs(distance_to_player.x)
	var zValue = abs(distance_to_player.z)
	
	#if the player if far from the limit of the inital postion of the enemy
	if xValue > safe_distance_to_player.x and zValue > safe_distance_to_player.z:
		move_to(initial_pos)
	else: # the player is in the limit then move to the player
		move_to(Player.transform.origin)
	#move_to(Player.transform.origin)
