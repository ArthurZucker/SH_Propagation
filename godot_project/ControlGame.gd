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
var scores = [null,null,null,null]
func _ready():
	get_node("Label").set_text("Id joueur : "+ global.controlMenuNode.get_child(0).player_name)

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
		'I': id_joueur = int(arra[0])
		'L': for i in range(4):
				liste_joueur[i]=int(arra[i])
		'M':
			#if(int(arra[0])==id_joueur): play()
			#print(id_joueur)
			if(int(arra[0])==id_joueur):
				if(my_cards[0]!=null):
					send_mess("R "+str(id_joueur)+" "+str(my_cards[0]))
				elif(my_cards[1]!=null):
					send_mess("H "+str(id_joueur)+" "+str(my_cards[1]))
				elif(my_cards[2]!=null):
					send_mess("H "+str(id_joueur)+" "+str(my_cards[2]))
				else:
					send_mess("O "+str(id_joueur))
		'D':
			if(int(arra[0])==id_joueur):
				for i in range(3):
					my_cards[i]=int(arra[i+1])
			get_node("Spatial").handCard(arra)
		'H':
			#var id_player = arra[0]
			var num_card = arra[1]
			cpt_card_hide=cpt_card_hide+1
			get_node("Spatial").hideCard(num_card)
			for i in range(3):
				if(my_cards[i]==num_card):
					empty_hand=i
		'R':
			#var id_player = arra[0]
			var num_card = arra[1]
			cpt_card_reveal=cpt_card_reveal+1
			get_node("Spatial").revealCard(num_card)
			for i in range(3):
				if(my_cards[i]==num_card):
					empty_hand=i
		'P':
			var id_player = arra[0]
			if(id_player==id_joueur):
				my_cards[empty_hand]=int(arra[1])
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
			scores = arra
			var root=get_tree().get_root()
			var myself=root.get_child(1)
			print (root,myself)
			root.remove_child(myself)
			root.add_child(global.controlScoreNode)

func _on_ButtonMenu_pressed():
	var root=get_tree().get_root()
	var myself=root.get_child(1)
	print (root,myself)
	root.remove_child(myself)
	root.add_child(global.controlMenuNode)

func play():
	get_node("Popup").set_visible(true)
	for i in range(3):
		var card = get_node("Popup").get_child(0).get_child(1).get_child(i)
		card.set_text("Carte "+my_cards[i])
		if(my_cards[i]==null):
			card.set_disable(true)

func _on_Carte1_pressed():
	selected_card = my_cards[0]
	index = 0

func _on_Carte2_pressed():
	selected_card = my_cards[1]
	index = 1
	
func _on_Carte3_pressed():
	selected_card = my_cards[2]
	index = 2
	
func _on_Hide_pressed():
	bool_action = -1
	get_node("Popup").set_visible(false)
	get_node("Popup").popup_hide()

func _on_Reveal_pressed():
	bool_action = 1
	get_node("Popup").set_visible(false)
	get_node("Popup").popup_hide()
