extends Node
export (PackedScene) var QuestionFeedbackCard

var AnswersButtonGroup
var question
var questions
var unansweredKeys
var answeredKeys = Array()
var randomIndex
var randomQuestionKey

func _ready():
	#group buttons so they act as radio buttons
	AnswersButtonGroup = ButtonGroup.new()
	$Answers/optionA.set_button_group(AnswersButtonGroup)
	$Answers/optionB.set_button_group(AnswersButtonGroup)
	$Answers/optionC.set_button_group(AnswersButtonGroup)
	$Answers/optionD.set_button_group(AnswersButtonGroup)
	
	#load json file with questions and parse it to the questions dictionary
	questions = self.load("res://leveldata/level1_questions_list.json")
	questions = JSON.parse(questions).result
	#fill unansweredKeys array with questions dictionary keys
	unansweredKeys = questions.keys()
	
	#ensure that a new seed will be used each time (if you want non-reproducible shuffling)
	randomize()
	#generate random key for the questions dictionary
	randomIndex = randi()%unansweredKeys.size()
		
	#select randomly chosen question from the questions dictionary
	randomQuestionKey = unansweredKeys[randomIndex]
	question = questions[str(randomQuestionKey)]
	
	set_question_txt(question.text)
	for i in range(4):
		set_answer_txt(i)

func load(var path):
	var file = File.new()
	file.open(path, File.READ)
	var content = file.get_as_text()
	file.close()
	return content
	
func set_question_txt(var txt):
	$QuestionText.text = " %s" % txt
	
func set_answer_txt(var answerNum):
	match answerNum:
		0: 
			$Answers/optionA.text = " %s" % question.optionA
		1: 
			$Answers/optionB.text = " %s" % question.optionB
		2: 
			$Answers/optionC.text = " %s" % question.optionC
		3: 
			$Answers/optionD.text = " %s" % question.optionD
	
func _on_Button_pressed():
	queue_free() 
	var question_feedback = preload("res://scenes/components/QuestionFeedbackCard.tscn").instance()
	self.get_parent().add_child(question_feedback)
	#selected correct answer
	if ((AnswersButtonGroup.get_pressed_button()==$Answers/optionA && question.answer=="a")
		|| (AnswersButtonGroup.get_pressed_button()==$Answers/optionB && question.answer=="b")
		|| (AnswersButtonGroup.get_pressed_button()==$Answers/optionC && question.answer=="c")
		|| (AnswersButtonGroup.get_pressed_button()==$Answers/optionD && question.answer=="d")):
		question_feedback.positive_feedback()
		
		#if answer is correct, remove question key from the unansweredKeys array 
		unansweredKeys.remove(randomIndex)
		#...and add it to the answeredKeys array
		answeredKeys.append(randomQuestionKey)
		
		#if unansweredKeys array is empty, refill it 
		if(unansweredKeys.empty()):
			unansweredKeys=answeredKeys
			answeredKeys.clear()
	#selected wrong answer or no answer selected
	else:
		question_feedback.negative_feedback()
