extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_name(var name):
	$LevelSelectorContainer/LevelInfoContainer/LevelNameLabel.text = " %s" % name

func set_progress(var full_runs, var current, var total):
	var progress_text = "      Prođena sva pitanja: %s\n      Trenutno odgovorena pitanja: %s/%s"
	$LevelSelectorContainer/LevelInfoContainer/LevelProgressLabel.text = progress_text % [full_runs, current, total]

func set_highscore(var score):
	$LevelSelectorContainer/HighScoreLabel.text = "Highscore:\n%s" % score
