extends Node2D

onready var consol_label = $Control/Label
const SAVE_DIR = "user://Saves/"
var save_path = SAVE_DIR + "save.data"

func console_write(value):
	consol_label.text += str(value) + "\n"
	pass


func _on_Save__button_pressed():
	var data = {
		"prenom": "Nick Anderson",
		"nom": "Azemar",
		"Age": 24,
		"Hauteur": 1.7
	}
	var dir = Directory.new()
	if !dir.dir_exists(SAVE_DIR):
		dir.make_dir_recursive(SAVE_DIR)#make every folders along the path if needed
		
	var file = File.new()
	var error = file.open_encrypted_with_pass(save_path, File.WRITE, "Nick")
	if error == OK:
		file.store_var(data)
		file.close()
		console_write("Data saved")
	else:
		console_write("Error - Data is not saved, error = " + str(error))
	pass # Replace with function body.



func _on_Load__button_pressed():
	var file = File.new()
	if file.file_exists(save_path):
		var error = file.open_encrypted_with_pass(save_path, file.READ, "Nick")
		if error == OK:
			var player_data = file.get_var()
			file.close()
			player_data["prenom"] = "Zoro" #set value
			console_write(player_data.get("prenom", null)) #get value
			console_write("Data loaded")
		else:
			console_write("Error - Data is not loaded, error = "+str(error))
	pass # Replace with function body.

func update_data():
	#To do
	pass
func delete_data():
	#To do
	pass
