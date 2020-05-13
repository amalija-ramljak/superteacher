extends Control

signal exit

func _ready():
	pass # Replace with function body.

func _on_GenericButton_button_up():
	emit_signal("exit")
