extends Control

export (PackedScene) var LevelSelector

# prepare level list, all user data...
func _ready():
	var levels = self.load("res://leveldata/list.tres")
	# list with elements "name/hs/full_runs/current/total"
	levels = levels.split("\n", false)
	for level in levels:
		# 0-name, 1-hs, 2-full_runs, 3-current, 4-total
		level = level.split("/", false)
		var level_selector = LevelSelector.instance()
		add_child(level_selector)
		level_selector.set_name(level[0])
		level_selector.set_highscore(level[1])
		level_selector.set_progress(level[2], level[3], level[4])


func load(var path):
	var file = File.new()
	file.open(path, File.READ)
	var content = file.get_as_text()
	file.close()
	return content
