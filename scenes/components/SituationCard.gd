extends Panel

var situation
var unseenSituations
var seenSituations
var randomSituationNumber

func _ready():
	#load json file with situations list and parse it to the unseenSituations dictionary
	unseenSituations = self.load("res://leveldata/level1_situations_list.json")
	unseenSituations = JSON.parse(unseenSituations).result
	
	#generate random key for the unseenSituations dictionary
	randomize()
	randomSituationNumber = randi()%unseenSituations.size()
	
	#if unseenSituations dictionary doesn't have random generated key, generate a new one
	while(!unseenSituations.has(str(randomSituationNumber))):
		randomize()
		randomSituationNumber = randi()%unseenSituations.size()
		
	#select randomly chosen situation from the unseenSituations dictionary
	situation = unseenSituations[str(randomSituationNumber)]
	#add chosen situation to the seenSituations dictionary
	seenSituations={str(randomSituationNumber): {"text": situation.text, "consequence": situation.consequence}}
	#...and remove it from the unseenSituations
	unseenSituations.erase(str(randomSituationNumber))
	
	set_situation_txt(situation.text)
	set_situation_consequence(int(situation.consequence))
	
	#if unseenSituations dictionary is empty, refill it 
	if(unseenSituations.empty()):
		unseenSituations=seenSituations
		seenSituations.clear()

func load(var path):
	var file = File.new()
	file.open(path, File.READ)
	var content = file.get_as_text()
	file.close()
	return content
	
func set_situation_txt(var txt):
	$SituationText.text = " %s" % txt
	
func set_situation_consequence(var consequenceCode):
	match consequenceCode:
		0: 
			$SituationConsequence.text = "Pomices se 3 polja naprijed!"
			#pomakni igraca naprijed
		1:
			$SituationConsequence.text = "Pomices se 3 polja natrag!"
			#pomakni igraca natrag

func _on_Button_pressed():
	queue_free()
	
