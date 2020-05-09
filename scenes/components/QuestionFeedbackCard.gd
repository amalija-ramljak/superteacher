extends Panel

func _on_Button_pressed():
	queue_free()
	
func positive_feedback():
	$QuestionFeedback.text = "Tocan odgovor!"
	$QuestionConsequence.text = "+1 bod"
	
func negative_feedback():
	$QuestionFeedback.text = "Pogresan odgovor!"
	$QuestionConsequence.text = "-1 bod"
	
func set_total_points():
	$TotalPointsLabel.text = "10 bodova"

