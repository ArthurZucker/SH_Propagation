extends Control

var id_joueur
var play
var my_cards=[null,null,null]
var liste_joueur=[null,null,null,null]

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func send_mess(mess):
	global.controlMenuNode.socket.set_dest_address("127.0.0.1", 4242)
	global.controlMenuNode.socket.put_packet(mess.to_ascii())

func _networkMessage(mess):
	#Message reçu dans control Menu! No worries about anything
	print ("_networkMessage=",mess)
	print(mess.right(2).split_floats(' '))
	var arra = mess.right(2).split_floats(' ')
	match mess[0]:
		'I': id_joueur= int(arra[0])
		'L': for i in range(4):
				liste_joueur[i]=int(arra[i])
		'M': if(int(arra[0])==id_joueur): play=true
		'D':
			print('D...............................................')
			for i in range(3):
				my_cards[i]=int(arra[i])
			get_node("Spatial").handCard()
			for i in range(3): 
				print(my_cards[i])
			print('D...............................................')
		'P': for i in range(3):
				if(my_cards[i]==null):
					my_cards[i]=int(arra[0])
					get_node("Spatial").drawCard(i)
		'H': get_node("Spatial").hideCard(int(arra[1]))
		'R': get_node("Spatial").revealCard(int(arra[1]))
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
	

