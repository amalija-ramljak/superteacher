extends VBoxContainer

export (PackedScene) var LevelSelector

var game_loader = load("res://GameSaving.gd")

func _ready():
	var f = File.new()
	f.open("res://leveldata/level_list.json", File.READ)
	var levels = parse_json(f.get_as_text())
	f.close()
	var levels_data = game_loader.load_game()
	var empty_control = get_child(0)
	for level in levels.list:
		var level_selector = LevelSelector.instance()
		add_child(level_selector)
		var level_data = levels_data.levels[level]
		level_selector.set_name(level)
		level_selector.set_progress(level_data.full_passes, level_data.current_correct, levels.pool_size[level])
		# terrible but oh well
		level_selector.get_child(0).connect("button_up", self.get_parent().get_parent(), "on_level_selected", [level_selector.level_name])
		if (!levels_data.unlocked.has(level)):
			level_selector.disable()
	remove_child(empty_control)
	add_child(empty_control)
