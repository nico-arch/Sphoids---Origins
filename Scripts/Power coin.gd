extends Area
signal coinCollected

export var rotation_speed : float = 2
var counter = 0

func _ready():
	pass

func _process(delta):
	rotate_y(deg2rad(rotation_speed))
	pass


func _on_coin_body_entered(body):
	if body.name == "Player" :
		#counter += 1
		#print("hit coin "+str(counter)+" time(s)")
		#$AnimationPlayer.play("coin_bounce")
		#$Timer.start()
		pass


func _on_Timer_timeout():
	emit_signal("coinCollected")
	#print("Signal emitted")
	queue_free()
	pass


func _on_Power_coin_body_shape_entered(body_id, body, body_shape, local_shape):
	#print("hit coin, player name: "+str(body.name))
	if body.name == "KinematicBody" :
		counter += 1
		#print("hit coin "+str(counter)+" time(s)")
		$AnimationPlayer.play("coin_bounce")
		$Timer.start()
		pass
