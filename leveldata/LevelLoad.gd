# helper functions to load a level
# like a parent class but I don't know OOP in Godot

var StartLevel = preload("res://scenes/components/StartLevel.tscn")
var player = preload("res://scenes/components/Player.tscn").instance()
var question_card = preload("res://scenes/components/QuestionCard.tscn").instance()
var situation_card = preload("res://scenes/components/SituationCard.tscn").instance()

var moreFieldsLeft
var playerPosition
var fieldName
var fieldIsQuestion

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
	
func load_situations(level_name):
	var f = File.new()
	var path = "res://leveldata/situations/%s.json" % level_name
	f.open(path, File.READ)
	var data = parse_json(f.get_as_text())
	f.close()
	return data

func set_situations(indices, level_node):
	for index in indices:
		level_node.get_child(1).get_child(index).situation()

func start_level(level_node):
	var play_button = StartLevel.instance()
	play_button.get_child(0).connect("button_up", level_node, "play_level")
	level_node.add_child(play_button)

func play(level_node):
	level_node.remove_child(level_node.get_child(level_node.get_child_count()-1))
	
	level_node.add_child(player)
	playerPosition = 0
	moreFieldsLeft = player.move(level_node.get_node("FieldsNode").get_children(), playerPosition, 0)
	
	level_node.add_child(question_card)
	question_card.load_card(level_node.questions)
	
	level_node.add_child(situation_card)
	
	#check level field type (question or situation)
	fieldName = "LevelField" + str(playerPosition)
	fieldIsQuestion = level_node.get_node("FieldsNode/"+str(fieldName)).question
		
func movePlayer(level_node, direction):
	if(moreFieldsLeft):
		moreFieldsLeft = player.move(level_node.get_node("FieldsNode").get_children(), playerPosition, direction)
		#prevent playerPosition to have negative values
		if(playerPosition == 0 && direction == -1):
			pass
		else:
			playerPosition = playerPosition + direction
	else:
		print("gotovo")
		var end_level_card = preload("res://scenes/components/EndLevelCard.tscn").instance()
		level_node.add_child(end_level_card)
	
	fieldName = "LevelField" + str(playerPosition)
	fieldIsQuestion = level_node.get_node("FieldsNode/"+str(fieldName)).question
	
	if(fieldIsQuestion):
		question_card.load_card(level_node.questions)
	else:
		situation_card.load_card(level_node.situations)
