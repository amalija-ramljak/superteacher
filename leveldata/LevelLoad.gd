# helper functions to load a level
# like a parent class but I don't know OOP in Godot

var StartLevel = preload("res://scenes/components/StartLevel.tscn")

func load_level(level_node, situation_indices):
	set_situations(situation_indices, level_node)
	return load_questions(level_node.level_name)

func load_questions(level_name):
	var f = File.new()
	var path = "res://leveldata/questions/%s.json" % level_name
	f.open(path, File.READ)
	var data = parse_json(f.get_as_text())
	f.close()
	return data

func set_situations(indices, level_node):
	for index in indices:
		level_node.get_child(index).situation()

func start_level(level_node):
	var play_button = StartLevel.instance()
	play_button.get_child(0).connect("button_up", level_node, "play_level")
	level_node.add_child(play_button)

func play(level_node):
	level_node.remove_child(level_node.get_child(level_node.get_child_count()-1))
