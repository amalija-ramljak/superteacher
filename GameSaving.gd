static func load_game():
	var game = File.new()
	var err = game.open("user://game.save", File.READ)
	if err:
		print("Nothing saved, so everything is empty!")
		return empty_save()
	else:
		# contains all levels as it is built over 
		var data = parse_json(game.get_as_text())
		game.close()
		var f = File.new()
		f.open("res://leveldata/level_list.json", File.READ)
		var levels = parse_json(f.get_as_text())
		f.close()
		return data

static func load_level(name):
	var game = File.new()
	game.open("user://game.save", File.READ)
	var level_data = parse_json(game.get_as_text()).levels[name]
	game.close()
	return level_data

static func save_game(name, level_data):
	var game = File.new()
	game.open("user://game.save", File.WRITE_READ)
	var data = parse_json(game.get_as_text())
	# check for new unlocked level
	var levels = File.new()
	levels.open("res://leveldata/level_list.json", File.READ)
	var level_list = parse_json(levels.get_as_text)
	levels.close()
	var next_level_index = level_list.list.find(name) + 1
	var next_level_name = level_list.list[next_level_index]
	if next_level_index < level_list.list.size() and !data.unlocked.has(next_level_name):
		print("Calculate unlocking stuff rule")
		var unlock_next = true
		for i in range(next_level_index - 1):
			unlock_next = unlock_next and data.levels[level_list.list[i]].full_passes > 0
		var current_level = data.levels[name]
		unlock_next = unlock_next and current_level.current_correct / level_list.pool_size[name] >= 0.6
		if unlock_next:
			data.unlocked.append(next_level_name)	
	data.levels[name] = level_data
	var f = File.new()
	var f_path = "res://leveldata/questions/%s.json" % next_level_name
	f.open(f_path, File.READ)
	# should exist and be replaced from the empty save
	data.levels[next_level_name].remaining_pool = parse_json(f.get_as_text()).keys()
	f.close()
	game.store_line(to_json(data))
	game.close()

# used for LevelSelector on first play
static func empty_save():
	var f = File.new()
	f.open("res://leveldata/level_list.json", File.READ)
	var levels = parse_json(f.get_as_text())
	f.close()
	var save_data = {
		'unlocked': ['Dvoriste'],
		'levels': {}
	}
	for level in levels.list:
		save_data.levels[level] = empty_level(level, levels.pool_size[level])
	return save_data
	
# used for empty saves (first play?) and LevelSelector for locked levels
static func empty_level(name, pool_size):
	var remaining_pool
	# the first level cannot be entirely empty!
	if name == 'Dvoriste':
		# fetch pool from wherever
		var f = File.new()
		f.open("res://leveldata/questions/Dvoriste.json", File.READ)
		remaining_pool = parse_json(f.get_as_text()).keys()
		f.close()
	else:
		remaining_pool = []
	return {
		'full_passes': 0,
		'pool_size': pool_size,
		'current_correct': 0,
		'remaining_pool': remaining_pool,
		'highscore': 0,
	}
