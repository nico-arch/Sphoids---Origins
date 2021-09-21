extends Label

var coin = 0
export var total_coin : int = 1

func _ready():
	text = str(coin)+"/"+str(total_coin)
	


"""func _on_coin_body_entered(body):
	coin +=1
	text = str(coin)
	pass # Replace with function body.
"""

func _on_coin_coinCollected():
	coin +=1
	_ready()
	if coin == 5:
		$Timer.start()
	#text = str(coin)



func _on_Timer_timeout():
	get_tree().change_scene("res://Scenes/You win.tscn")


func _on_Power_coin_coinCollected():
	#print("HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH")
	coin +=1
	_ready()
	if coin == total_coin:
		$Timer.start()
	#text = str(coin)
