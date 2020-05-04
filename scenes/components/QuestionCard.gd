extends Node
export (PackedScene) var QuestionFeedbackCard

var AnswersButtonGroup
var question
var unansweredQuestions
var answeredQuestions

func _ready():
	#group buttons so they act as radio buttons
	AnswersButtonGroup = ButtonGroup.new()
	$Answers/answerA.set_button_group(AnswersButtonGroup)
	$Answers/answerB.set_button_group(AnswersButtonGroup)
	$Answers/answerC.set_button_group(AnswersButtonGroup)
	$Answers/answerD.set_button_group(AnswersButtonGroup)
	
	#load json file with questions list and parse it to the unansweredQuestions dictionary
	unansweredQuestions = self.load("res://leveldata/level1_questions_list.json")
	unansweredQuestions = JSON.parse(unansweredQuestions).result
	
	#generate random key for the unansweredQuestions dictionary
	randomize()
	var randomQuestionNumber = randi()%unansweredQuestions.size()
	
	#if unseenSituations dictionary doesn't have random generated key, generate a new one
	while(!unansweredQuestions.has(str(randomQuestionNumber))):
		randomize()
		randomQuestionNumber = randi()%unansweredQuestions.size()
		
	#select randomly chosen question from the unansweredQuestions dictionary
	question = unansweredQuestions[str(randomQuestionNumber)]
	
	#add chosen question to the answeredQuestions dictionary
	answeredQuestions={str(randomQuestionNumber): {"text": question.text, "answer": question.answer, "optionA": question.optionA, "optionB": question.optionB, "optionC": question.optionC, "optionD": question.optionD}}
	#...and remove it from the unansweredQuestions
	unansweredQuestions.erase(str(randomQuestionNumber))
	set_question_txt(question.text)
	for i in range(4):
		set_answer(i)
		
	#if unansweredQuestions dictionary is empty, refill it 
	if(unansweredQuestions.empty()):
		unansweredQuestions=answeredQuestions
		answeredQuestions.clear()

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
	var question_feedback = preload("res://scenes/components/QuestionFeedbackCard.tscn").instance()
	self.get_parent().add_child(question_feedback)
	#selected correct answer
	if (AnswersButtonGroup.get_pressed_button()):
		question_feedback.positive_feedback()
		print(AnswersButtonGroup.get_pressed_button())
	#selected wrong answer
	elif (AnswersButtonGroup.get_pressed_button()):
		question_feedback.negative_feedback()
		print("druga")
	#no answer selected, but pressed the answer button
	else:
		print("treca")
	
