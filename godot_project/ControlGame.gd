extends Control

var answers=[null,null,null,null,null,null,null,null,null,null]
var pressed_answers = [0,0,0,0,0,0,0,0,0,0]
var id_joueur
var my_cards=[null,null,null]
var liste_joueur=[null,null,null,null]
var cpt_card_reveal=0
var cpt_card_hide=0
var empty_hand
var selected_card
var bool_action
var index
var shuffle
var hidden
var hidden5
var scores = [null,null,null,null]
func _ready():
	get_node("Label").set_text("Name joueur : "+ global.controlMenuNode.get_child(0).player_name)
	get_node("ColorRect").hide()
	get_node("ColorRect2").hide()
	get_node("ColorRect3").hide()
	get_node("ColorRect4").hide()
	get_node("ColorRect5").hide()
	get_node("ButtonMenu3").hide()
	hidden = true
	hidden5 = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func send_mess(mess):
	var control = global.controlMenuNode.get_child(0)
	print("supposed to send : "+mess)
	control.socket.set_dest_address("127.0.0.1", 4242)
	control.socket.put_packet(mess.to_ascii())

func _networkMessage(mess):
	#Message reçu dans control Menu! No worries about anything
	print ("_networkMessage=",mess)
	print(mess.right(2).split_floats(' '))
	var arra = mess.right(2).split_floats(' ')
	match mess[0]:
		'I': 
			id_joueur = int(arra[0])
			get_node("Label").set_text("Name joueur : "+ global.controlMenuNode.get_child(0).player_name + "\nID joueur : "+str(id_joueur))
			#get_node("Spatial/Camera").init_pos()
		'L': for i in range(4):
				liste_joueur[i]=int(arra[i])
		'C':
			shuffle = arra
			get_node("Spatial")._create()
		'M':
			if(arra[0]==id_joueur):
				if(my_cards[0]!=null):
					play()
				elif(my_cards[1]!=null):
					play()
				elif(my_cards[2]!=null):
					play()
				else:
					send_mess("O "+str(id_joueur))
		'D':
			if(int(arra[0])==id_joueur):
				for i in range(3):
					my_cards[i]=arra[i+1]
			get_node("Spatial").handCard(arra)
		'H':
			#var id_player = arra[0]
			var num_card = arra[1]
			empty_hand = arra[2]
			get_node("Spatial").hideCard(num_card)
			cpt_card_hide=cpt_card_hide+1
		'R':
			#var id_player = arra[0]
			var num_card = arra[1]
			empty_hand = arra[2]
			get_node("Spatial").revealCard(num_card)
			cpt_card_reveal=cpt_card_reveal+1
		'P':
			var id_player = arra[0]
			if(id_player==id_joueur):
				my_cards[empty_hand]=arra[1]
			get_node("Spatial").drawCard(arra,empty_hand)
		'E':
			var id_player = arra[0]
			if(id_player==id_joueur):
				my_cards[empty_hand]=null
		'Q':
			get_node("ColorRect2").show()
		'S':
			get_node("ColorRect3").hide()
			get_node("ColorRect4").show()
			get_node("ButtonMenu3").show()
			scores = arra
			var label = get_node("ColorRect4/Label")
			var result = ""
			for i in range(4):
				if(i!=id_joueur):
					var score = global.controlGameNode.scores[i]
					var chaine ="\nId du joueur : "+str(i)+".\tSon score :"+str(score)
					result += chaine
				else:
					var score = global.controlGameNode.scores[i]
					var chaine ="\tVotre score :"+str(score)+"\n"
					if(score<=6):
						chaine += "\tInspecteur Lestrade : vous subirez les moqueries de Sherlock encore un certain temps. Vous devez donc résoudre une nouvelle affaire au plus vite!"
					elif(score<=10):
						chaine += "\tJohn Watson : Vous avez résolu l'affaire. Mais avouez que cela n'a pas été sans peine! "
					elif(score<=14):
						chaine += "\tIrène Adler : Sherlock lui-même est impréssioné par votre génie! Tout le monde ne peut pas en dire autant!"
					elif(score<=17):
						chaine += "\tMicroft Holmes : Ne laissez jamais la réputation de votre frère entacher votre talent. Ce n'est pas pour rien que vous travaillez au services de Sa Majesté"
					elif(score >=18):
						chaine += "\tSherlock Holmes : Excellent. Vous êtes son égal."
					result += chaine 
			label.text=result

func _on_ButtonMenu_pressed():
	var root=get_tree().get_root()
	var myself=root.get_child(1)
	print (root,myself)
	root.remove_child(myself)
	root.add_child(global.controlMenuNode)

func play():
	for i in  range(3):
		print(my_cards[i])
		if(my_cards[i] == null):
			get_node("Popup").get_child(0).get_child(1).get_child(i).hide()
		else:
			get_node("Popup").get_child(0).get_child(1).get_child(i).set_text("Carte "+str(my_cards[i]))
			get_node("Popup").get_child(0).get_child(1).get_child(i).show()
	get_node("Popup").show()
	get_node("Popup/VBoxContainer/HR/Hide").hide()
	get_node("Popup/VBoxContainer/HR/Reveal").hide()


func _on_Carte1_pressed():
	selected_card = my_cards[0]
	get_node("Popup/VBoxContainer/HR/Hide").show()
	get_node("Popup/VBoxContainer/HR/Reveal").show()
	index = 0

func _on_Carte2_pressed():
	selected_card = my_cards[1]
	get_node("Popup/VBoxContainer/HR/Hide").show()
	get_node("Popup/VBoxContainer/HR/Reveal").show()
	
	index = 1

func _on_Carte3_pressed():
	selected_card = my_cards[2]
	get_node("Popup/VBoxContainer/HR/Hide").show()
	get_node("Popup/VBoxContainer/HR/Reveal").show()
	index = 2

func _on_Hide_pressed():
	bool_action = -1
	get_node("Popup").popup_hide()
	get_node("Popup/VBoxContainer/Card_Select/Carte1").set_pressed(false)
	get_node("Popup/VBoxContainer/Card_Select/Carte2").set_pressed(false)
	get_node("Popup/VBoxContainer/Card_Select/Carte3").set_pressed(false)

func _on_Reveal_pressed():
	bool_action = 1
	get_node("Popup").popup_hide()
	get_node("Popup/VBoxContainer/Card_Select/Carte1").set_pressed(false)
	get_node("Popup/VBoxContainer/Card_Select/Carte2").set_pressed(false)
	get_node("Popup/VBoxContainer/Card_Select/Carte3").set_pressed(false)


func _on_ButtonMenu2_pressed():
	get_node("ColorRect4").hide()
	if(hidden == true):
		get_node("ColorRect").show()
		hidden = false
		if(hidden5 == false):
				get_node("ColorRect5").hide()
				hidden5 = true
	else:
		get_node("ColorRect").hide()
		hidden = true
#Question 1
func _on_CheckBox_pressed():
	answers[0] = 1
	pressed_answers[0] = 1
func _on_CheckBox2_pressed():
	answers[0] = 2
	pressed_answers[0] = 1
func _on_CheckBox3_pressed():
	answers[0] = 3
	pressed_answers[0] = 1
func _on_CheckBox4_pressed():
	answers[0] = 4
	pressed_answers[0] = 1

#Question 2
func _on_CheckBox8_pressed():
	answers[1] = 1
	pressed_answers[1] = 1
func _on_CheckBox7_pressed():
	answers[1] = 2
	pressed_answers[1] = 1
func _on_CheckBox6_pressed():
	answers[1] = 3
	pressed_answers[1] = 1
func _on_CheckBox5_pressed():
	answers[1] = 4
	pressed_answers[1] = 1


func _on_CheckBox12_pressed():
	answers[2] = 1
	pressed_answers[2] = 1
func _on_CheckBox11_pressed():
	answers[2] = 2
	pressed_answers[2] = 1
func _on_CheckBox10_pressed():
	answers[2] = 3
	pressed_answers[2] = 1
func _on_CheckBox9_pressed():
	answers[2] = 4
	pressed_answers[2] = 1
	
func _on_CheckBox16_pressed():
	answers[3] = 1
	pressed_answers[3] = 1
func _on_CheckBox15_pressed():
	answers[3] = 2
	pressed_answers[3] = 1
func _on_CheckBox14_pressed():
	answers[3] = 3
	pressed_answers[3] = 1
func _on_CheckBox13_pressed():
	answers[3] = 4
	pressed_answers[3] = 1
	
func _on_CheckBox20_pressed():
	answers[4] = 1
	pressed_answers[4] = 1
func _on_CheckBox19_pressed():
	answers[4] = 2
	pressed_answers[4] = 1
func _on_CheckBox18_pressed():
	answers[4] = 3
	pressed_answers[4] = 1
func _on_CheckBox17_pressed():
	answers[4] = 4
	pressed_answers[4] = 1
	
func _on_CheckBox24_pressed():
	answers[5] = 1
	pressed_answers[5] = 1
func _on_CheckBox23_pressed():
	answers[5] = 2
	pressed_answers[5] = 1
func _on_CheckBox22_pressed():
	answers[5] = 3
	pressed_answers[5] = 1
func _on_CheckBox21_pressed():
	answers[5] = 4
	pressed_answers[5] = 1


func _on_CheckBox28_pressed():
	answers[6] = 1
	pressed_answers[6] = 1
func _on_CheckBox27_pressed():
	answers[6] = 2
	pressed_answers[6] = 1
func _on_CheckBox26_pressed():
	answers[6] = 3
	pressed_answers[6] = 1
func _on_CheckBox25_pressed():
	answers[6] = 4
	pressed_answers[6] = 1


func _on_CheckBox32_pressed():
	answers[7] = 1
	pressed_answers[7] = 1
func _on_CheckBox31_pressed():
	answers[7] = 2
	pressed_answers[7] = 1
func _on_CheckBox30_pressed():
	answers[7] = 3
	pressed_answers[7] = 1
func _on_CheckBox29_pressed():
	answers[7] = 4
	pressed_answers[7] = 1


func _on_CheckBox36_pressed():
	answers[8] = 1
	pressed_answers[8] = 1
func _on_CheckBox35_pressed():
	answers[8] = 2
	pressed_answers[8] = 1
func _on_CheckBox34_pressed():
	answers[8] = 3
	pressed_answers[8] = 1
func _on_CheckBox33_pressed():
	answers[8] = 4
	pressed_answers[8] = 1


func _on_CheckBox40_pressed():
	answers[9] = 1
	pressed_answers[9] = 1
func _on_CheckBox39_pressed():
	answers[9] = 2
	pressed_answers[9] = 1
func _on_CheckBox38_pressed():
	answers[9] = 3
	pressed_answers[9] = 1
func _on_CheckBox37_pressed():
	answers[9] = 4
	pressed_answers[9] = 1


func _on_Button_pressed():
	
	var sum = 0
	for i in range(10):
		sum+=pressed_answers[i]
	if(sum==10):
		var control  = global.controlGameNode
		var reponse = ""
		for i in range(10):
			reponse+= str(answers[i])+" "
		control.send_mess("Q "+str(control.id_joueur)+" " + reponse)
		get_node("ColorRect2").hide()
		get_node("ColorRect3").show()
	else:
		print("vous n'avez pas répondu à toutes les questions")
		
		
func _on_ButtonMenu3_pressed():
	get_node("ColorRect4").hide()
	if(hidden5 == true):
		get_node("ColorRect5").show()
		hidden5 = false
		if(hidden==false):
			get_node("ColorRect").hide()
			hidden = true
	else:
		get_node("ColorRect5").hide()
		hidden5 = true
