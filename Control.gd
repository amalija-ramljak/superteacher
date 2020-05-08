extends Control

func _ready():
	pass # Replace with function body.


var next_scene = preload("res://scenes/Main.tscn")

func _on_Button_pressed():
	get_tree().change_scene_to(next_scene)

