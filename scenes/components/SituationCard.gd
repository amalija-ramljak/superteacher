extends Panel

var situation
#var situations
var notSeenKeys
var seenKeys = Array()
var randomIndex
var randomSituationKey

func load_card(situations):
	notSeenKeys = situations.keys()
	
	#ensure that a new seed will be used each time (if you want non-reproducible shuffling)
	randomize()
	#generate random key for the situations dictionary
	randomIndex = randi()%notSeenKeys.size()
	
	#select randomly chosen situation from the situations dictionary
	randomSituationKey = notSeenKeys[randomIndex]
	situation = situations[str(randomSituationKey)]
	
	#add chosen situation to the seenKeys array
	seenKeys.append(randomSituationKey)
	#...and remove it from the notSeenKeys
	notSeenKeys.remove(randomIndex)
	
	set_situation_txt(situation.text)
	set_situation_consequence(int(situation.consequence))
	
	#if notSeenKeys array is empty, refill it 
	if(notSeenKeys.empty()):
		notSeenKeys=seenKeys
		seenKeys.clear()
	
	self.visible = true

func _ready():
	self.visible = false
	self.get_node("Button").connect("button_up", self.get_parent(), "move")
	#load json file with situations list and parse it to the situations dictionary
	#situations = self.load("res://leveldata/situations/level1_situations_list.json")
	#situations = JSON.parse(situations).result
	#fill notSeenKeys array with situations dictionary keys
	#notSeenKeys = situations.keys()
	
	#ensure that a new seed will be used each time (if you want non-reproducible shuffling)
	#randomize()
	#generate random key for the situations dictionary
	#randomIndex = randi()%notSeenKeys.size()
	
	#select randomly chosen situation from the situations dictionary
	#randomSituationKey = notSeenKeys[randomIndex]
	#situation = situations[str(randomSituationKey)]
		
	#add chosen situation to the seenKeys array
	#seenKeys.append(randomSituationKey)
	#...and remove it from the notSeenKeys
	#notSeenKeys.remove(randomIndex)
	
	#set_situation_txt(situation.text)
	#set_situation_consequence(int(situation.consequence))
	
	#if notSeenKeys array is empty, refill it 
	#if(notSeenKeys.empty()):
	#	notSeenKeys=seenKeys
	#	seenKeys.clear()

#func load(var path):
	#var file = File.new()
	#file.open(path, File.READ)
	#var content = file.get_as_text()
	#file.close()
	#return content
	
func set_situation_txt(var txt):
	$SituationText.text = " %s" % txt
	
func set_situation_consequence(var consequenceCode):
	match consequenceCode:
		1: 
			$SituationConsequence.text = "Pomices se 1 polje naprijed!"
			self.get_parent().set_direction(1)
		2:
			$SituationConsequence.text = "Pomices se 2 polja naprijed!"
			self.get_parent().set_direction(2)
		3:
			$SituationConsequence.text = "Pomices se 3 polja naprijed!"
			self.get_parent().set_direction(3)
		-1:
			$SituationConsequence.text = "Pomices se 1 polje natrag!"
			self.get_parent().set_direction(-1)
		-2:
			$SituationConsequence.text = "Pomices se 2 polja natrag!"
			self.get_parent().set_direction(-2)
		-3:
			$SituationConsequence.text = "Pomices se 3 polja natrag!"
			self.get_parent().set_direction(-3)

func _on_Button_pressed():
	self.visible = false
	
	
