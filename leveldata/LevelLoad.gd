# helper functions to load a level
# like a parent class but I don't know OOP in Godot

var StartLevel = preload("res://scenes/components/StartLevel.tscn")

func load_level(level_node, situation_indices, question_path):
	set_situations(situation_indices, level_node)
	return load_questions(question_path)

func load_questions(question_path):
	return [{'question':'Text of question', 'answers': ['T', 'N1', 'N2', 'N3']}]

func set_situations(indices, level_node):
	for index in indices:
		level_node.get_child(index).situation()

func start_level(level_node):
	var play_button = StartLevel.instance()
	play_button.get_child(0).connect("button_up", level_node, "play_level")
	level_node.add_child(play_button)

func play(level_node):
	pass
