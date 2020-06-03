extends Control

var id_joueur
var play
var my_cards=[null,null,null]
var liste_joueur=[null,null,null,null]
var cpt_card_reveal=[0,0,0,0]
var cpt_card_hide=[0,0,0,0]
var empty_hand
var test = 0 
var selected_card
var bool_action
func _ready():
	pass # Replace with function body.

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
		'I': id_joueur= int(arra[0])
		'L': for i in range(4):
				liste_joueur[i]=int(arra[i])
		'M': 
			if(int(arra[0])==id_joueur): play=true
			send_mess("R "+str(id_joueur)+" "+str(my_cards[0]))
			#play()
		'D':
			if(int(arra[0])==id_joueur):
				for i in range(3):
					my_cards[i]=int(arra[i+1])
			get_node("Spatial").handCard(arra)
		'H':
			var id_player = arra[0]
			var num_card = arra[1]
			cpt_card_hide[id_player]=cpt_card_hide[id_player]+1
			get_node("Spatial").hideCard(id_player,num_card)
			for i in range(3):
				if(my_cards[i]==num_card):
					empty_hand=i
		'R': 
			var id_player = arra[0]
			var num_card = arra[1]
			cpt_card_reveal[id_player]= cpt_card_reveal[id_player]+1
			get_node("Spatial").revealCard(id_player,num_card)
			for i in range(3):
				if(my_cards[i]==num_card):
					empty_hand=i
		'P': 
			if(int(arra[0])==id_joueur):
				my_cards[empty_hand]=int(arra[1])
			get_node("Spatial").drawCard(arra,empty_hand)
		'Q': 
			var root=get_tree().get_root()
			var myself=root.get_child(1)
			print (root,myself)
			root.remove_child(myself)
			root.add_child(global.controlEndGameNode)
		'S':
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
	get_node("Popup").popup()

func _on_Carte1_pressed():
	selected_card = 0
	
	
func _on_Carte2_pressed():
	selected_card = 1

func _on_Carte3_pressed():
	selected_card = 2

func _on_Hide_pressed():
	bool_action = -1
	get_node("Popup").popup_hide()

func _on_Reveal_pressed():
	bool_action = 1
	get_node("Popup").popup_hide()
