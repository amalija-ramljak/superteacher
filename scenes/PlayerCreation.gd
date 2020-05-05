extends Control

var player_name

func _ready():
	pass

func _on_PlayerName_text_changed(new_text):
	self.player_name = new_text

func male():
	configure_player("male")

func female():
	configure_player("female")
	
func configure_player(gender):
	# creates a new config file - first time opening game!
	var config = ConfigFile.new()
	config.set_value("player_data", "name", self.player_name)
	config.set_value("player_data", "gender", gender)
	config.save("user://settings.cfg")
