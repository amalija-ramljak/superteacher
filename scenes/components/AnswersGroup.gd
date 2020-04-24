extends GridContainer

var AnswersButtonGroup
# Called when the node enters the scene tree for the first time.
func _ready():
	AnswersButtonGroup = ButtonGroup.new()
	$answerA.set_button_group(AnswersButtonGroup)
	$answerB.set_button_group(AnswersButtonGroup)
	$answerC.set_button_group(AnswersButtonGroup)
	$answerD.set_button_group(AnswersButtonGroup)
	pass # Replace with function body.


func _on_Button_pressed():
	print(AnswersButtonGroup.get_pressed_button())
	print($answerA)
	#selected correct answer
	if (AnswersButtonGroup.get_pressed_button()):
		print("prva")
	#selected wrong answer
	elif (AnswersButtonGroup.get_pressed_button()):
		print("druga")
	#no answer selected, but pressed the answer button
	else:
		print("treca")
