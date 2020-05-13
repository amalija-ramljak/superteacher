extends Panel

func _ready():
	self.visible = false

func add_text(level, pool_size, level_data_old, level_data_new):
	$Title.text = "Razina %s dovršena" % level
	$Content.text = "Napredak:\n%d/%d => %d/%d" % [level_data_old.current_correct, pool_size, level_data_new.current_correct, pool_size]
	if level_data_old.full_passes < level_data_new.full_passes:
		$Content.text += "\n\n"
		$Content.text += "Proden cijeli skup pitanja!\n"
		$Content.text += "%d => %d" % [level_data_old.full_passes, level_data_new.full_passes]

func show():
	self.visible = true

func _on_EndLevelButton_button_up():
	get_tree().change_scene("res://scenes/Main.tscn")
