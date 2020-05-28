extends Node2D

var question = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func situation():
	self.question = false
	$Sprite.texture = load("res://visuals/images/smallstar.png")
