extends Node2D

func _ready():
	var f = ConfigFile.new()
	f.load("user://settings.cfg")
	var avatar = f.get_value("player_data", "gender")
	$Sprite.texture = load("res://icon.png")

# need to move fields in level inside a separate component
func move(fields, current_index, move_by):
	var new_index = current_index + move_by
	if new_index < fields.size():
		# indices are 0-22, field size should be 23
		if new_index < 0:
			# back to field 1 and continue game!
			$Sprite.position = fields[0].position
		else:
			$Sprite.position = fields[new_index].position
		return 1
	else:
		# if the index when moved is too large, the level is finished
		# last position + finish
		$Sprite.position = fields[fields.size()-1].position
		return 0
