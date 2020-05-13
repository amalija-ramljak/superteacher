extends Panel

var situation = {
	"text": "",
	"consequence": 0,
}
var randomIndex
var randomSituationKey
var feedback

signal move_by

func load_card(s):
	situation = s
	set_situation_txt(situation.text)
	set_situation_consequence(int(situation.consequence))
	self.visible = true

func _ready():
	self.visible = false

func set_situation_txt(txt):
	$SituationText.text = txt
	
func set_situation_consequence(consequenceCode):
	feedback = consequenceCode
	match consequenceCode:
		1: 
			$SituationConsequence.text = "Pomices se 1 polje naprijed!"
		2:
			$SituationConsequence.text = "Pomices se 2 polja naprijed!"
		3:
			$SituationConsequence.text = "Pomices se 3 polja naprijed!"
		-1:
			$SituationConsequence.text = "Pomices se 1 polje natrag!"
		-2:
			$SituationConsequence.text = "Pomices se 2 polja natrag!"
		-3:
			$SituationConsequence.text = "Pomices se 3 polja natrag!"

func _on_Button_pressed():
	self.visible = false
	emit_signal("move_by", feedback)
