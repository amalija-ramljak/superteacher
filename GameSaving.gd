func load_game():
	var game = File.new()
	game.open("user://game.save", File.READ)

func save_game():
	var game = File.new()
	game.open("user://game.save", File.WRITE)
