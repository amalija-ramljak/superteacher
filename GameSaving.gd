static func load_game():
	var game = File.new()
	var err = game.open("user://game.save", File.READ)
	if err:
		return empty_save()
	else:
		# contains all levels
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
	
	var f = File.new()
	f.open("res://leveldata/level_list.json", File.READ)
	var level_list = parse_json(f.get_as_text)
	f.close()

	# add the last played level new data, necessary for unlock check
	data.levels[name] = level_data

	if data.unlocked.size() < level_list.list.size():
		var fll_index = data.unlocked.size()
		var fll_name = level_list.list[fll_index]
		var lul_name = data.unlocked[fll_index-1]
		var lul = data.levels[lul_name]
		var unlock_next = lul.current_correct / level_list.pool_size[lul_name] >= 0.6 or lul.full_passes > 0
		if fll_index - 2 >= 0:
			unlock_next = unlock_next and data.levels[level_list.list[fll_index-2]].full_passes > 0
		if unlock_next:
			data.unlocked.append(fll_name)
			
			var f_path = "res://leveldata/questions/%s.json" % fll_name
			f.open(f_path, File.READ)
			data.levels[fll_name].remaining_pool = parse_json(f.get_as_text()).keys()
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
	
static func empty_level(name, pool_size):
	var remaining_pool
	# the first level cannot be entirely empty!
	if name == 'Dvoriste':
		var f = File.new()
		#f.open("res://leveldata/questions/Dvoriste.json", File.READ)
		f.open("res://leveldata/level1_question_list.json", File.READ)
		remaining_pool = parse_json(f.get_as_text())
		f.close()
	else:
		remaining_pool = []
	return {
		'full_passes': 0,
		'pool_size': pool_size,
		'current_correct': 0,
		'remaining_pool': remaining_pool,
	}
