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
	
	# creates an empty save!
	var game_loader = load("res://leveldata/GameSaving.gd")
	var game = File.new()
	game.open("user://game.save", File.WRITE)
	game.store_line(to_json(game_loader.empty_save()))
	game.close()
	get_tree().change_scene("res://scenes/Main.tscn")
