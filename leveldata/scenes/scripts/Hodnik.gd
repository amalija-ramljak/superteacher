extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	var situations = [5, 9, 13]
	for number in situations:
		var c = self.get_child(number+1)
		c.situation()
	
