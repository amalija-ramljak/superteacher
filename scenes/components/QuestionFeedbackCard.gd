extends Panel

func _on_Button_pressed():
	queue_free()
	
func positive_feedback():
	$QuestionFeedbackCard/QuestionFeedback.text = "Tocan odgovor!"
	$QuestionFeedbackCard/QuestionConsequence.text = "+1 bod"
	
func negative_feedback():
	$QuestionFeedbackCard/QuestionFeedback.text = "Pogresan odgovor!"
	$QuestionFeedbackCard/QuestionConsequence.text = "-1 bod"
	
func set_total_points():
	$QuestionFeedbackCard/TotalPointsLabel.text = "10 bodova"

