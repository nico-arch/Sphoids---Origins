extends Area
signal coinCollected

var rotation_speed = 2
var counter = 0

func _ready():
	pass

func _physics_process(delta):
	rotate_y(deg2rad(rotation_speed))
	pass


func _on_coin_body_entered(body):
	if body.name == "Player" :
		#counter += 1
		#print("hit coin "+str(counter)+" time(s)")
		$AnimationPlayer.play("coin_bounce")
		$Timer.start()
		pass


func _on_Timer_timeout():
	emit_signal("coinCollected")
	queue_free()
	pass
