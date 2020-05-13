# helper functions to load a level
# like a parent class but I don't know OOP in Godot

var StartLevel = preload("res://scenes/components/StartLevel.tscn")

var moreFieldsLeft
var playerPosition
var fieldName
var fieldIsQuestion

static func load_questions(level_name):
	var f = File.new()
	var path = "res://leveldata/questions/%s.json" % level_name
	f.open(path, File.READ)
	var data = parse_json(f.get_as_text())
	f.close()
	return data
	
static func load_situations(level_name):
	var f = File.new()
	var path = "res://leveldata/situations/%s.json" % level_name
	f.open(path, File.READ)
	var data = parse_json(f.get_as_text())
	f.close()
	return data

static func set_situations(level_node):
	for index in level_node.situation_numbers:
		level_node.get_child(1).get_child(index).situation()

static func play(level_node):
	level_node.get_node("Extras/StartLevel").hide()
	level_node.get_node("Extras/StartLevel").disabled = true
	level_node.player.move(level_node.fields, 0)
	level_node.player.show()
	play_turn(level_node, 0)
		
static func play_turn(level_node, move_by):
	# if move returns false, it means the level is over
	var end = !level_node.player.move(level_node.fields, move_by)
	if end:
		var end_card = level_node.get_node("Cards/EndLevelCard")
		end_card.add_text(level_node.level_name, level_node.level_data.pool_size, level_node.saved_loader.load_level(level_node.level_name), level_node.level_data)
		end_card.show()
	else:
		# sleep
		yield(level_node.get_tree().create_timer(0.25), "timeout")
		# otherwise it plays!
		if level_node.fields[level_node.player.index].question:
			var question = pick_random(level_node.level_data.remaining_pool)
			level_node.question_card.load_card(question)
		else:
			var situation = pick_random(level_node.situations.keys())
			level_node.situation_card.load_card(level_node.situations[situation])

static func pick_random(list):
	randomize()
	var rand_index = randi() % list.size()
	return list[rand_index]
