extends Control

# the functions shared by levels
var saved_loader = preload("res://GameSaving.gd")
var level_loader = preload("res://leveldata/LevelLoad.gd")
var level_name = "Dvoriste"
var level_data

var questions
var situations
var situation_numbers = [7, 15, 21]

var question_card
var situation_card
var fields
var player

func _ready():
	question_card = $Cards/QuestionCard
	situation_card = $Cards/SituationCard
	situation_card.connect("move_by", self, "move")
	player = $Extras/Player
	fields = $FieldsNode.get_children()
	# the saved level data - remaining pool, full passes...
	level_data = saved_loader.load_level(level_name)
	# the full q and s lists for this level
	questions = level_loader.load_questions(level_name)
	situations = level_loader.load_situations(level_name)
	level_loader.set_situations(self)
	player.move(fields, 0)
	player.show()

func play_level():
	level_loader.play(self)

func move(move_by):
	level_loader.play_turn(self, move_by)

func _on_ExitLevel_exit():
	get_tree().change_scene("res://scenes/Main.tscn")
