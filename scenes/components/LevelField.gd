extends Node2D

var question = true
var index = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func set_index(number):
	self.index = number

func situation():
	self.question = false
	$Sprite.texture = load("res://visuals/images/smallstar.png")
