extends KinematicBody

export var is_debug: bool = false
export var zoom_min : float = 5
export var zoom_max : float = 50
export var zoom_speed : float = 5

export var is_ball : bool = true
export var speed : float = 20
export var boost_speed : float = 10
export var ROTATE_SPEED : float = 10 #(speed/4)
export var ROTATE_BOOST_SPEED : float = 10 #(speed/4)

export var acceleration : float = 15
export var airAcceleration : float = 5
export var mass : float = 1
export var gravity : float = 0.98
export var maxVelocity : float = 54
export var jumpPower : float = 20

export(float, 0.1, 1) var mouseSensitivity : float = 0.3
export(float, -90, 0) var minPitch : float = -90 #minimun camera angle movement
export(float, 0, 90) var maxPitch : float = 90 #maximun camera angle movement

var velocity : Vector3
var y_velocity : float
var is_ui_cancel : bool = false
var counter_click : int = 0

var current_rotation_speed : float = 0

onready var zoom = $"Camera pivot/Camera Boom"
onready var cameraPivot = $"Camera pivot"
#onready var camera = $"Camera pivot/Camera Boom/Camera"

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	current_rotation_speed  = ROTATE_SPEED


# warning-ignore:unused_argument
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"): #if esc button is pressed
		if is_ui_cancel:
			is_ui_cancel = false
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			is_ui_cancel = true
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	handle_movement(delta)


func _input(event):
	if event is InputEventMouseMotion and !is_ui_cancel:
		rotation_degrees.y -= event.relative.x * mouseSensitivity
		cameraPivot.rotation_degrees.x -= event.relative.y * mouseSensitivity
		cameraPivot.rotation_degrees.x = clamp(cameraPivot.rotation_degrees.x, minPitch, maxPitch)
		
	if event is InputEventMouseButton and !is_ui_cancel:
		if event.is_pressed():
			if event.button_index == BUTTON_WHEEL_UP:
				if zoom.get_length() > zoom_min:
					#print("Zoom value = "+str(zoom.get_length()))
					var zoomValue = zoom.get_length()
					zoom.set_length(zoomValue - zoom_speed )
					if is_debug:
						print ("Zoom = "+str(zoomValue))
						
		if event.button_index == BUTTON_WHEEL_DOWN:
				if zoom.get_length() < zoom_max:
					#print("Zoom value = "+str(zoom.get_length()))
					var zoomValue = zoom.get_length()
					zoom.set_length(zoomValue + zoom_speed )
					if is_debug:
						print ("Zoom = "+str(zoomValue))
		#if event.button_index == BUTTON_RIGHT:
		#	counter_click += 1
		#	print("Right click "+str(counter_click)+" time(s)")
		#	pass

func _physics_process(delta):
	
	pass
	



func handle_movement(delta):
	var direction = Vector3()
	
	if Input.is_action_pressed("ui_up"):
		direction -= transform.basis.z
		if is_ball:
			$MeshInstance.rotate_x(deg2rad(-current_rotation_speed))
	if Input.is_action_pressed("ui_down"):
		direction += transform.basis.z
		if is_ball:
			$MeshInstance.rotate_x(deg2rad(current_rotation_speed))
		
	if Input.is_action_pressed("ui_left"):
		direction -= transform.basis.x
		if is_ball:
			$MeshInstance.rotate_z(deg2rad(current_rotation_speed))
		
	if Input.is_action_pressed("ui_right"):
		direction += transform.basis.x
		if is_ball:
			$MeshInstance.rotate_z(deg2rad(-current_rotation_speed))
		
	direction = direction.normalized()
	
	var accel = acceleration if is_on_floor() else airAcceleration
	if !Input.is_action_pressed("ui_speed") and is_on_floor():
		velocity = velocity.linear_interpolate(direction * speed, accel * delta)
		current_rotation_speed = ROTATE_SPEED
	if Input.is_action_pressed("ui_speed") and is_on_floor():
		velocity = velocity.linear_interpolate(direction * (speed+ boost_speed), accel * delta)
		current_rotation_speed = ROTATE_BOOST_SPEED
	#velocity = velocity.linear_interpolate(direction * speed, accel * delta)
	
	if is_on_floor():
		y_velocity = -0.01
	else:
		y_velocity = clamp(y_velocity - gravity*mass, -maxVelocity, maxVelocity)
		
	
	if Input.is_action_just_pressed("ui_jump") and is_on_floor():
		y_velocity = jumpPower
		
	velocity.y = y_velocity
	
	
		
	velocity = move_and_slide(velocity, Vector3.UP)





