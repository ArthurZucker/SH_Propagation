extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	hide() # Replace with function body.

func popup_hide():
	hide()
	var control  = get_tree().get_root().get_node("ControlGame")
	match control.bool_action:
		-1: control.send_mess("H "+str(control.id_joueur)+" "+str(control.selected_card))
		1 : control.send_mess("R "+str(control.id_joueur)+" "+str(control.selected_card))
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
