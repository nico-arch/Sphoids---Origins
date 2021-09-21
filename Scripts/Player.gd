extends KinematicBody

const SPEED = 20
const ROTATE_SPEED = (SPEED/5)
const LERP_PERCENT_STOP = 0.1

var playerName = "Nico"
var velocity = Vector3(0,0,0)
var floor_normal = Vector3(0, -1, 0)
var counter = 0
func _ready():
	print("Hello "+playerName)

func _physics_process(delta):
	#if is_on_floor():
	#	counter +=1
	#	print("is on floor "+str(counter))
	if is_on_wall():
		velocity.y -= 0.1
		#counter +=1
		#print("is_on_wall "+str(counter))
	if Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_left"):
		velocity.x =0
	elif Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
		$MeshInstance.rotate_z(deg2rad(-ROTATE_SPEED))
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
		$MeshInstance.rotate_z(deg2rad(ROTATE_SPEED))
	else:
		velocity.x = lerp(velocity.x, 0, LERP_PERCENT_STOP)
		
	if Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_down"):
		velocity.z = 0
	elif Input.is_action_pressed("ui_up"):
		velocity.z = -SPEED
		$MeshInstance.rotate_x(deg2rad(-ROTATE_SPEED))
	elif Input.is_action_pressed("ui_down"):
		velocity.z = SPEED
		$MeshInstance.rotate_x(deg2rad(ROTATE_SPEED))
	else:
		velocity.z = lerp(velocity.z, 0, LERP_PERCENT_STOP)
	
	move_and_slide(velocity)

func _on_enemy1_body_entered(body):
	#print("player collided with enemy")
	if body.name == "Player" :
		get_tree().change_scene("res://Scenes/Game over.tscn")
