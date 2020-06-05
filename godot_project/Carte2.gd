extends CheckBox

# Called when the node enters the scene tree for the first time.
func _ready():
	if(global.controlGameNode.my_cards[1]==null): # Si pas de carte ne pas afficher
		hide()
