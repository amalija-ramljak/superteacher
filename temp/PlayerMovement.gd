static func move_player(avatar_node, fields, current_index, move_by):
	var new_index = current_index + move_by
	if new_index < fields.size():
		avatar_node.rect_position = fields[new_index].rect_position
	else:
		# level finished
		pass
