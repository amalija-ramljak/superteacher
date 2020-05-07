extends Control

var level_name
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_name(var name):
	$LevelSelectorButton/LevelSelectorContainer/LevelInfoContainer/LevelNameLabel.text = " %s" % name
	self.level_name = name

func set_progress(var full_runs, var current, var total):
	var progress_text = "          Prođena sva pitanja: %s\n          Trenutno odgovorena pitanja: %s/%s"
	$LevelSelectorButton/LevelSelectorContainer/LevelInfoContainer/LevelProgressLabel.text = progress_text % [full_runs, current, total]

func set_highscore(var score):
	$LevelSelectorButton/LevelSelectorContainer/HighScoreLabel.text = "Highscore:\n%s" % score

func disable():
	var button = self.get_child(0)
	button.disabled = true
