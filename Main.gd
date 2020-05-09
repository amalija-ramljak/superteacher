extends Control

func _ready():
	pass

func load(path):
	var file = File.new()
	file.open(path, File.READ)
	var content = file.get_as_text()
	file.close()
	return content
	
func on_level_selected(level_name):
	var path = "res://leveldata/scenes/%s.tscn" % level_name
	var level_scene = load(path)
	get_tree().change_scene_to(level_scene)
