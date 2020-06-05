extends Control

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
var scores = [null,null,null,null]
func _ready():
	get_node("Label").set_text("Name joueur : "+ global.controlMenuNode.get_child(0).player_name)

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
			get_node("Label").set_text("Name joueur : "+ global.controlMenuNode.get_child(0).player_name + "ID joueur : "+str(id_joueur))
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
			var root=get_tree().get_root()
			var myself=root.get_child(1)
			print (root,myself)
			root.remove_child(myself)
			root.add_child(global.controlEndGameNode)
		'S':
			global.controlScoreNode._change()

func _on_ButtonMenu_pressed():
	var root=get_tree().get_root()
	var myself=root.get_child(1)
	print (root,myself)
	root.remove_child(myself)
	root.add_child(global.controlMenuNode)

func play():
	for i in  range(3):
		if(my_cards[i] == null):
			get_node("Popup").get_child(0).get_child(1).get_child(i).hide()
		else:
			get_node("Popup").get_child(0).get_child(1).get_child(i).set_text("Carte "+str(my_cards[i]))
	get_node("Popup").show()


func _on_Carte1_pressed():
	selected_card = my_cards[0]
	get_node("Popup").get_child(2).show()
	index = 0

func _on_Carte2_pressed():
	selected_card = my_cards[1]
	get_node("Popup").get_child(2).show()
	index = 1

func _on_Carte3_pressed():
	selected_card = my_cards[2]
	get_node("Popup").get_child(2).show()
	index = 2

func _on_Hide_pressed():
	bool_action = -1
	get_node("Popup").popup_hide()

func _on_Reveal_pressed():
	bool_action = 1
	get_node("Popup").popup_hide()


func _on_ButtonMenu2_pressed():
	pass # Replace with function body.
