extends Node
export (PackedScene) var QuestionFeedbackCard

var level_node

var AnswersButtonGroup
var question_feedback
var question
var question_index
var answerIndex = [0, 1, 2]

func load_card(qi):
	question_index = qi
	question = level_node.questions[question_index]
	#shuffle answers order
	answerIndex.shuffle()
	set_question_txt(question.text)
	set_answers_txt()
	
	self.visible=true

func _ready():
	#group buttons so they act as radio buttons
	AnswersButtonGroup = ButtonGroup.new()
	$Answers/optionA.set_button_group(AnswersButtonGroup)
	$Answers/optionB.set_button_group(AnswersButtonGroup)
	$Answers/optionC.set_button_group(AnswersButtonGroup)
	level_node = self.get_parent().get_parent()
	question_feedback = self.get_parent().get_node("QuestionFeedbackCard")
	question_feedback.connect("move_by", self.get_parent().get_parent(), "move")
	
func set_question_txt(txt):
	$QuestionText.text = txt
	
func set_answers_txt():
	$Answers/optionA.text = question.answers[answerIndex[0]]
	$Answers/optionB.text = question.answers[answerIndex[1]]
	$Answers/optionC.text = question.answers[answerIndex[2]]
	
func _on_Button_pressed():
	self.visible = false 
	question_feedback.visible = true
	var pressed_button = AnswersButtonGroup.get_pressed_button()
	if pressed_button != null:
		if pressed_button.text == question.answers[0]:
			level_node.level_data.remaining_pool.remove(level_node.level_data.remaining_pool.find((question_index)))
			print(level_node.level_data.remaining_pool)
			if level_node.level_data.remaining_pool.size() == 0:
				level_node.level_data.remaining_pool = level_node.questions.keys()
				level_node.level_data.full_passes += 1
			level_node.level_data.current_correct += 1
			level_node.level_data.current_correct = int(int(level_node.level_data.current_correct) % level_node.questions.size())
			question_feedback.positive_feedback()
		else:
			question_feedback.negative_feedback()
		AnswersButtonGroup.get_pressed_button().pressed = false
	else:
		question_feedback.negative_feedback()

