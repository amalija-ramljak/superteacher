func load_game():
	var game = File.new()
	game.open("user://game.save", File.READ)

func save_game(name, level_data):
	var game = File.new()
	game.open("user://game.save", File.READ_WRITE)
	var data = parse_json(game.get_as_text())
	# check for new unlocked level
	var levels = File.new()
	levels.open("res://leveldata/level_list.json")
	var level_list = parse_json(levels.get_as_text())
	var next_level = level_list.find(name) + 1
	if next_level < level_list.size() and !data.unlocked.has(level_list[next_level]):
		print("Calculate unlocking stuff rule")
		var unlock_next = true
		for i in range(next_level - 1):
			unlock_next = unlock_next and data.levels[level_list[i]].full_passes > 0
		var current_level = data.levels[name]
		unlock_next = unlock_next and current_level.current_correct / current_level.total_pool >= 0.6
		if unlock_next:
			data.unlocked.append(level_list[next_level])
	data.levels[name] = level_data
	game.store_line(to_json(data))
	game.close()
