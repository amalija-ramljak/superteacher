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
	$SituationConsequence.text = "Pomičeš se %d %s %s" % [abs(consequenceCode),
		"polje" if abs(consequenceCode) == 1 else "polja",
		"naprijed" if consequenceCode > 0 else "natrag"]

func _on_Button_pressed():
	self.visible = false
	emit_signal("move_by", feedback)
