extends Control

export (PackedScene) var LevelSelector

# prepare level list, all user data...
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
		level_selector.rect_position.y += i * 120
		if (!levels.playable.has(level)):
			level_selector.disabled = true
		i += 1

func load(var path):
	var file = File.new()
	file.open(path, File.READ)
	var content = file.get_as_text()
	file.close()
	return content
