# helper functions to load a level

func load_level(level_node, situation_indices, question_path):
	set_situations(situation_indices, level_node)
	return load_questions(question_path)

func load_questions(question_path):
	return [{'question':'Text of question', 'answers': ['T', 'N1', 'N2', 'N3']}]

func set_situations(indices, level_node):
	var situation_texture = load("res://visuals/images/smallstar.png")
	for index in indices:
		level_node.get_child(index).get_child(0).texture = situation_texture
