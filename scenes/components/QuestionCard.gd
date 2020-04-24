extends Node

func _ready():
	var questions = self.load("res://leveldata/hallway_questions_list.json")
	questions = JSON.parse(questions).result
	randomize()
	var randomQuestionNumber = randi()%questions.size()
	var question = questions[str(randomQuestionNumber)]
	set_question_txt(question.text)
	set_answer("a", question.optionA)
	set_answer("b", question.optionB)
	set_answer("c", question.optionC)
	set_answer("d", question.optionD)
	print(question)

func load(var path):
	var file = File.new()
	file.open(path, File.READ)
	var content = file.get_as_text()
	file.close()
	return content
	
func set_question_txt(var txt):
	$QuestionText.text = " %s" % txt
	
func set_answer(var label, var txt):
	match label:
		"a": 
			$Answers/answerA.text = " %s" % txt
		"b": 
			$Answers/answerB.text = " %s" % txt
		"c": 
			$Answers/answerC.text = " %s" % txt
		"d": 
			$Answers/answerD.text = " %s" % txt
	

