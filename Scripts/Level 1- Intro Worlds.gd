extends Spatial
export var currentScene : NodePath

func _ready():
	pass


func _on_Door_1_body_shape_entered(body_id, body, body_shape, local_shape):
	#print (str(body.name)+" Enterred")
	if body.name == "KinematicBody" :
		#get_tree().change_scene("res://Scenes/Levels/Level 5 - Ico world.tscn")
		SceneChanger.goto_scene("res://Scenes/Levels/Level 5 - Ico world.tscn",get_node(currentScene))


func _on_Door_2_body_shape_entered(body_id, body, body_shape, local_shape):
	if body.name == "KinematicBody" :
		#get_tree().change_scene("res://Scenes/Levels/Level 4 - Cylinder World.tscn")
		SceneChanger.goto_scene("res://Scenes/Levels/Level 4 - Cylinder World.tscn",get_node(currentScene))


func _on_Door_3_body_shape_entered(body_id, body, body_shape, local_shape):
	if body.name == "KinematicBody" :
		#get_tree().change_scene("res://Scenes/Levels/Level 3 - Cone world.tscn")
		SceneChanger.goto_scene("res://Scenes/Levels/Level 3 - Cone world.tscn",get_node(currentScene))


func _on_Door_4_body_shape_entered(body_id, body, body_shape, local_shape):
	if body.name == "KinematicBody" :
		#get_tree().change_scene("res://Scenes/Levels/Level 2 - Cube world.tscn")
		SceneChanger.goto_scene("res://Scenes/Levels/Level 2 - Cube world.tscn",get_node(currentScene))
