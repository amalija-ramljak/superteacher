extends Control

# the functions shared by levels
var level_loader = preload("res://leveldata/LevelLoad.gd").new()
var level_name = "Dvoriste"

var question_path = "res://leveldata/questions/Dvoriste.json"
var questions

var situation_path = "res://leveldata/situations/Dvoriste.json"
var situation_numbers = [7, 15, 21]
var situations

var direction

func _ready():
	questions = level_loader.load_level(self, situation_numbers)
	situations = level_loader.load_situations(level_name)
	level_loader.start_level(self)
	
func set_direction(directionVar):
	direction = directionVar

func play_level():
	level_loader.play(self)
	
func move():
	level_loader.movePlayer(self, direction)
