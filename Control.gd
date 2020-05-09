extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

var level_selector = preload("res://scenes/Main.tscn")

func _on_Button_pressed():
	var config = ConfigFile.new()
	var err = config.load("user://settings.cfg")
	if err == OK:
		get_tree().change_scene_to(level_selector)
	else:
		get_tree().change_scene("res://scenes/PlayerCreation.tscn")

func load(var path):
	var file = File.new()
	file.open(path, File.READ)
	var content = file.get_as_text()
	file.close()
	return content
