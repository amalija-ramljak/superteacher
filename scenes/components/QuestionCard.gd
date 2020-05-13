extends Node
export (PackedScene) var QuestionFeedbackCard

var AnswersButtonGroup
var question_feedback = preload("res://scenes/components/QuestionFeedbackCard.tscn").instance()
var question
#var questions
var unansweredKeys
var answeredKeys = Array()
var randomIndex
var randomQuestionKey
var answerIndex = [0, 1, 2, 3]

func load_card(var questions):
	unansweredKeys = questions.keys()
	
	#ensure that a new seed will be used each time (if you want non-reproducible shuffling)
	randomize()
	#generate random key for the questions dictionary
	randomIndex = randi()%unansweredKeys.size()
		
	#select randomly chosen question from the questions dictionary
	randomQuestionKey = unansweredKeys[randomIndex]
	question = questions[str(randomQuestionKey)]
	
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
	$Answers/optionD.set_button_group(AnswersButtonGroup)
	
	self.get_parent().add_child(question_feedback)
	
	#load json file with questions and parse it to the questions dictionary
	#questions = self.load("res://leveldata/questions/Dvoriste.json")
	#questions = JSON.parse(questions).result
	#fill unansweredKeys array with questions dictionary keys
	#unansweredKeys = questions.keys()
	
	#ensure that a new seed will be used each time (if you want non-reproducible shuffling)
	#randomize()
	#generate random key for the questions dictionary
	#randomIndex = randi()%unansweredKeys.size()
		
	#select randomly chosen question from the questions dictionary
	#randomQuestionKey = unansweredKeys[randomIndex]
	#question = questions[str(randomQuestionKey)]
	
	#shuffle answers order
	#answerIndex.shuffle()
	
	#set_question_txt(question.text)
	#set_answers_txt()

#func load(var path):
	#var file = File.new()
	#file.open(path, File.READ)
	#var content = file.get_as_text()
	#file.close()
	#return content
	
func set_question_txt(var txt):
	$QuestionText.text = " %s" % txt
	
func set_answers_txt():
		$Answers/optionA.text = " %s" % question.answers[answerIndex[0]]
		$Answers/optionB.text = " %s" % question.answers[answerIndex[1]]
		$Answers/optionC.text = " %s" % question.answers[answerIndex[2]]
		$Answers/optionD.text = " %s" % question.answers[answerIndex[3]]
	
func _on_Button_pressed():
	self.visible = false 
	question_feedback.visible = true
	
	#selected correct answer
	if ((AnswersButtonGroup.get_pressed_button()==$Answers/optionA && str(answerIndex[0])==question.correctAnswer)
		|| (AnswersButtonGroup.get_pressed_button()==$Answers/optionB && str(answerIndex[1])==question.correctAnswer)
		|| (AnswersButtonGroup.get_pressed_button()==$Answers/optionC && str(answerIndex[2])==question.correctAnswer)
		|| (AnswersButtonGroup.get_pressed_button()==$Answers/optionD && str(answerIndex[3])==question.correctAnswer)):
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
