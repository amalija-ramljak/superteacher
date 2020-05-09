extends Control

# the functions shared by levels
var level_loader = preload("res://leveldata/LevelLoad.gd").new()

var question_path = "res://leveldata/questions/dvoriste.json"
var questions

var situation_path = "res://leveldata/situations/dvoriste.json"
var situation_numbers = [7, 15, 21]

func _ready():
	questions = level_loader.load_level(self, situation_numbers, question_path)
