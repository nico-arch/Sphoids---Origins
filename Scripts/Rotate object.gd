extends Area

export var rotation_speed : float = 0.1

func _physics_process(delta):
	rotate_y(deg2rad(rotation_speed))
	pass
