extends Button

export var currentScene : NodePath

func _ready():
	pass


func _on_buttonplay_pressed():
	#get_tree().change_scene("res://Scenes/Level.tscn")
	#get_tree().change_scene("res://Scenes/Levels/Level 1- Intro Worlds.tscn")
	
	SceneChanger.goto_scene("res://Scenes/Levels/Level 1- Intro Worlds.tscn",get_node(currentScene))
	#get_tree().change_scene("res://Scenes/Levels/Level 1- Intro Worlds.tscn")
	#get_tree().change_scene("res://Scenes/Main menu.tscn")
	
