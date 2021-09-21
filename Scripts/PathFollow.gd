extends PathFollow
export var speed : float = 0.002
var counter = 0
var stop: bool = false

func _process(delta):
	
	if stop == false:
		counter += speed
		#print("Counter = "+str(counter))
		set_unit_offset(counter)
		#print("counter = "+str(counter))



func _on_Enemy_seePlayer():
	if !stop:
		stop = true


func _on_Enemy_dontSeePlayer():
	if stop:
		stop = false
