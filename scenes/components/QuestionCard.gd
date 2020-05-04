extends Node
export (PackedScene) var QuestionFeedbackCard

var AnswersButtonGroup
var question

func _ready():
	AnswersButtonGroup = ButtonGroup.new()
	$Answers/answerA.set_button_group(AnswersButtonGroup)
	$Answers/answerB.set_button_group(AnswersButtonGroup)
	$Answers/answerC.set_button_group(AnswersButtonGroup)
	$Answers/answerD.set_button_group(AnswersButtonGroup)
	
	var questions = self.load("res://leveldata/hallway_questions_list.json")
	questions = JSON.parse(questions).result
	randomize()
	var randomQuestionNumber = randi()%questions.size()
	question = questions[str(randomQuestionNumber)]
	set_question_txt(question.text)
	for i in range(4):
		set_answer(i)

func load(var path):
	var file = File.new()
	file.open(path, File.READ)
	var content = file.get_as_text()
	file.close()
	return content
	
func set_question_txt(var txt):
	$QuestionText.text = " %s" % txt
	
func set_answer(var answerNum):
	match answerNum:
		0: 
			$Answers/answerA.text = " %s" % question.optionA
		1: 
			$Answers/answerB.text = " %s" % question.optionB
		2: 
			$Answers/answerC.text = " %s" % question.optionC
		3: 
			$Answers/answerD.text = " %s" % question.optionD
	
func _on_Button_pressed():
	queue_free() 
	var question_feedback = QuestionFeedbackCard.instance()
	#selected correct answer
	if (AnswersButtonGroup.get_pressed_button()):
		question_feedback.positive_feedback()
		print("prva")
	#selected wrong answer
	elif (AnswersButtonGroup.get_pressed_button()):
		question_feedback.negative_feedback()
		print("druga")
	#no answer selected, but pressed the answer button
	else:
		print("treca")
	
