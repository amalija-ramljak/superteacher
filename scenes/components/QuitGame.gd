extends Button

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_QuitGame_button_up():
	get_tree().quit()


func _on_Cog_button_up():
	self.visible = true
