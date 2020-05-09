extends VBoxContainer


export (PackedScene) var LevelSelector

func _ready():
	var levels = self.load("res://leveldata/level_list.json")
	levels = JSON.parse(levels).result
	print(levels)
	var i = 0
	for level in levels.list:
		var level_selector = LevelSelector.instance()
		add_child(level_selector)
		level_selector.set_name(level)
		level_selector.set_highscore(levels[level].highscore)
		level_selector.set_progress(levels[level].full_runs, levels[level].current, levels[level].total)
		# terrible but oh well
		level_selector.get_child(0).connect("button_up", self.get_parent().get_parent(), "on_level_selected", [level_selector.level_name])
		if (!levels.playable.has(level)):
			level_selector.disable()
		i += 1

func load(path):
	var file = File.new()
	file.open(path, File.READ)
	var content = file.get_as_text()
	file.close()
	return content
