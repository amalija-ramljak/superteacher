extends Panel

func _ready():
	self.visible = false
	self.get_node("Button").connect("button_up", self.get_parent(), "move")

func _on_Button_pressed():
	self.visible = false
	
func positive_feedback():
	$QuestionFeedback.text = "Tocan odgovor!"
	$QuestionConsequence.text = "Pomices se jedno polje naprijed!"
	self.get_parent().set_direction(1)
	
func negative_feedback():
	$QuestionFeedback.text = "Pogresan odgovor!"
	$QuestionConsequence.text = "Pomices se jedno polje natrag!"
	self.get_parent().set_direction(-1)
