extends Control

var answers=[null,null,null,null,null,null,null,null,null,null]
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


#Question 1
func _on_CheckBox_pressed():
	answers[0] = 1
func _on_CheckBox2_pressed():
	answers[0] = 2
func _on_CheckBox3_pressed():
	answers[0] = 3
func _on_CheckBox4_pressed():
	answers[0] = 4

#Question 2
func _on_CheckBox8_pressed():
	answers[1] = 1
func _on_CheckBox7_pressed():
	answers[1] = 2
func _on_CheckBox6_pressed():
	answers[1] = 3
func _on_CheckBox5_pressed():
	answers[1] = 4


func _on_CheckBox12_pressed():
	answers[2] = 1
func _on_CheckBox11_pressed():
	answers[2] = 2
func _on_CheckBox10_pressed():
	answers[2] = 3
func _on_CheckBox9_pressed():
	answers[2] = 4
	
func _on_CheckBox16_pressed():
	answers[3] = 1
func _on_CheckBox15_pressed():
	answers[3] = 2
func _on_CheckBox14_pressed():
	answers[3] = 3
func _on_CheckBox13_pressed():
	answers[3] = 4
	
func _on_CheckBox20_pressed():
	answers[4] = 1
func _on_CheckBox19_pressed():
	answers[4] = 2
func _on_CheckBox18_pressed():
	answers[4] = 3
func _on_CheckBox17_pressed():
	answers[4] = 4
	
func _on_CheckBox24_pressed():
	answers[5] = 1
func _on_CheckBox23_pressed():
	answers[5] = 2
func _on_CheckBox22_pressed():
	answers[5] = 3
func _on_CheckBox21_pressed():
	answers[5] = 4


func _on_CheckBox28_pressed():
	answers[6] = 1
func _on_CheckBox27_pressed():
	answers[6] = 2
func _on_CheckBox26_pressed():
	answers[6] = 3
func _on_CheckBox25_pressed():
	answers[6] = 4


func _on_CheckBox32_pressed():
	answers[7] = 1
func _on_CheckBox31_pressed():
	answers[7] = 2
func _on_CheckBox30_pressed():
	answers[7] = 3
func _on_CheckBox29_pressed():
	answers[7] = 4


func _on_CheckBox36_pressed():
	answers[8] = 1
func _on_CheckBox35_pressed():
	answers[8] = 2
func _on_CheckBox34_pressed():
	answers[8] = 3
func _on_CheckBox33_pressed():
	answers[8] = 4


func _on_CheckBox40_pressed():
	answers[9] = 1
func _on_CheckBox39_pressed():
	answers[9] = 2
func _on_CheckBox38_pressed():
	answers[9] = 3
func _on_CheckBox37_pressed():
	answers[9] = 4


func _on_Button_pressed():
	var control  = global.controlGameNode
	var reponse = ""
	for i in range(10):
		reponse+= str(answers[i])+" "
	control.send_mess("Q "+str(control.id_joueur)+" " + reponse)
	get_node("ScrollContainer/GridContainer/VBoxContainer10/Button").hide()
	var label = Label.new()
	label.align = label.ALIGN_CENTER
	label.autowrap = true
	label.text = "Merci pour votre réponse! Veuillez patienter le temps que les autres joueurs répondent"
	get_node("ScrollContainer/GridContainer/VBoxContainer10").add_child(label)

func _change():	
	var root=get_tree().get_root()
	var myself=root.get_child(1)
	print (root,myself)
	root.remove_child(myself)
	root.add_child(global.controlScoreNode)
	
