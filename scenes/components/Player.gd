extends Node2D

var index = 0

func _ready():
	var f = ConfigFile.new()
	f.load("user://settings.cfg")
	var avatar = f.get_value("player_data", "gender")
	print(avatar)
	self.texture = load("res://icon.png")

# need to move fields in level inside a separate component
func move(fields, move_by):
	var new_index = index + move_by
	if new_index < fields.size():
		# indices are 0-22, field size should be 23
		if new_index < 0:
			# back to field 1 and continue game!
			self.position = fields[0].position
			index = 0
		else:
			self.position = fields[new_index].position
			index = new_index
		return true
	else:
		# if the index when moved is too large, the level is finished
		# last position + finish
		self.position = fields[fields.size()-1].position
		index = fields.size()-1
		return false
