extends Panel

var feedback
signal move_by

func _ready():
	self.visible = false
	connect("move_by", self.get_parent().get_parent(), "move")

func _on_Button_pressed():
	self.visible = false
	emit_signal("move_by", feedback)
	
func positive_feedback():
	$QuestionFeedback.text = "Tocan odgovor!"
	$QuestionConsequence.text = "Pomices se jedno polje naprijed!"
	self.feedback = 1
	
func negative_feedback():
	$QuestionFeedback.text = "Pogresan odgovor!"
	$QuestionConsequence.text = "Pomices se jedno polje natrag!"
	self.feedback = -1
