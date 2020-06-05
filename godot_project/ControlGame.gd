extends Control

var answers=[null,null,null,null,null,null,null,null,null,null]	# Stock les réponses aux 10 questions
var pressed_answers = 0											# Permet de compter le nombre de questions avec réponse
var id_joueur													# Id du joueur
var my_cards=[null,null,null]									# Stock les 3 cartes en main
var liste_joueur=[null,null,null,null]							# Stock le nom des tous les joueurs
var cpt_card_reveal=0											# Compte le nombre total de cartes révélées pour les répartir sur la table
var cpt_card_hide=0												# Compte le nombre total de cartes cachées pour les répartir sur la table
var empty_hand													# Boolean indiquant l'indexe de la position de la carte absente dans la main du joeur
var selected_card												# La carte choisi par les boutons à jouer ou révéler
var bool_action													# Reveler ou Cacher
var index														# Index de la carte choisie dans my_cards
var shuffle														# Tableau stockant le mélange des cartes pour qu'elles s'affichent dans l'ordre physiquement
var introduction_is_hidden= true								# Permet de gérer l'affichage de l'introduction
var solution_is_hidden											# Permet de gérer l'e rectangle de affichage de la solution'
var scores = [null,null,null,null]								# Stock les scores

func _ready():
	# On écrit le nom du joueur
	get_node("infos").set_text("Name joueur\t: "+ global.controlMenuNode.get_child(0).player_name)
	# On cache tous les noeuds qui vont apparaitre après
	get_node("Introduction").hide()
	get_node("Solution").hide()
	get_node("Patientez").hide()
	get_node("Questionnaire").hide()
	get_node("Scores").hide()
	get_node("Playing").hide()
	get_node("ButtonSolu").hide()
	# On initalise les boolean
	introduction_is_hidden= true
	solution_is_hidden= true
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func send_mess(mess):
	# Fonction permettant d'envoyer un message au serveur
	var control = global.controlMenuNode.get_child(0)
	control.socket.set_dest_address("127.0.0.1", 4242)
	control.socket.put_packet(mess.to_ascii())

func _networkMessage(mess):
	#Message reçu dans control Menu! No worries about anything
	# Traitement du message reçu par le client
	# On utilise split_floats pour récupérer facilement tous les nombres
	var arra = mess.right(2).split_floats(' ') #Stock le tableau des valeurs reçues
	match mess[0]:
		'I': 
			id_joueur = int(arra[0])
			get_node("infos").set_text("Name joueur\t: "+ global.controlMenuNode.get_child(0).player_name + "\nID joueur\t: "+str(id_joueur))
			# On reçoi son identifiant selon le serveur et affiche 
		'L': for i in range(4):
				liste_joueur[i]=int(arra[i])
			# On reçoit le nom des autres joueures
		'C':
			shuffle = arra
			get_node("Spatial")._create()
			# On reçpit la distribution des cartes, pour que la pioche soit bien formée
			# TODO translate not good
		'M': # On reçoit le joueur à qui c'est de jouer
			if(arra[0]==id_joueur): #Si c'est à nous
				get_node("Playing").hide()
				if(my_cards[0]!=null): 
					play()
				elif(my_cards[1]!=null):
					play()
				elif(my_cards[2]!=null):
					play()
				else:
					# Si on a plus de cartes
					send_mess("O "+str(id_joueur))
			else: # Si on ne joue pas on affiche celui qui joue
				var playing = get_node("Playing").get_child(0)
				playing.text = str(arra[0]) + " est en train de jouer"
				get_node("Playing").show()
		'D': # Récupère les 3 première carte de la distribution initiales
			if(int(arra[0])==id_joueur):
				for i in range(3):
					my_cards[i]=arra[i+1] # Initialise le tableau de la main (3 cartes en main)
			get_node("Spatial").handCard(arra) # Déplace les cartes physiquement pour tous les joueurs
		'H':# Une carte a été cachée (Hide)
			#var id_player = arra[0]
			var num_card = arra[1]
			empty_hand = arra[2]
			get_node("Spatial").hideCard(num_card)
			cpt_card_hide=cpt_card_hide+1
		'R':# Une carte a été révélée (Reveal)
			#var id_player = arra[0]
			var num_card = arra[1]
			empty_hand = arra[2]
			get_node("Spatial").revealCard(num_card)
			cpt_card_reveal=cpt_card_reveal+1
		'P': # Pioche une carte, au bon endroit dans la main
			var id_player = arra[0]
			if(id_player==id_joueur):
				my_cards[empty_hand]=arra[1] 
			get_node("Spatial").drawCard(arra,empty_hand)
		'E': # La pioche est vide
			var id_player = arra[0]
			if(id_player==id_joueur):
				my_cards[empty_hand]=null
		'Q':# Active la fenetre de question
			get_node("Questionnaire").show()
		'S':# Donne les scores et les affiche
			get_node("Patientez").hide()
			get_node("Scores").show()
			get_node("ButtonSolu").show() 
			scores = arra
			var label = get_node("Scores/Label")
			var result = "" # Chaine qui stock les résultats pour tous les joueurs
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
			label.text=result # Associe la chaine finale à l'object de l'interface graphique

func _on_ButtonMenu_pressed(): # Revien au menu principal
	var root=get_tree().get_root()
	var myself=root.get_child(1)
	print (root,myself)
	root.remove_child(myself)
	root.add_child(global.controlMenuNode)

func play(): # Permet d'afficher la fenêtre de séléction d'une carte à cahcher ou révéler
	for i in  range(3):
		print(my_cards[i])
		if(my_cards[i] == null):
			get_node("play").get_child(0).get_child(1).get_child(i).hide() # Ne pas choisir une carte null!!! Hyper important
		else:
			get_node("play").get_child(0).get_child(1).get_child(i).set_text("Carte "+str(my_cards[i])) # Affiche le bon numéros de la carte
			get_node("play").get_child(0).get_child(1).get_child(i).show()
	get_node("play").show() # Montre l'interface de séléction
	get_node("play/VBoxContainer/HR/Hide").hide()	# Cache ces boutons pour ne pas révélé ou caché sans avoir choisi une carte
	get_node("play/VBoxContainer/HR/Reveal").hide()


func _on_Carte1_pressed(): # Choisis de révéler la carte 1
	selected_card = my_cards[0]
	get_node("play/VBoxContainer/HR/Hide").show()
	get_node("play/VBoxContainer/HR/Reveal").show()
	index = 0

func _on_Carte2_pressed(): # Choisis de révéler la carte 2 
	selected_card = my_cards[1]
	get_node("play/VBoxContainer/HR/Hide").show()
	get_node("play/VBoxContainer/HR/Reveal").show()
	index = 1
	
func _on_Carte3_pressed(): # Choisis de révéler la carte 3
	selected_card = my_cards[2]
	get_node("play/VBoxContainer/HR/Hide").show()
	get_node("play/VBoxContainer/HR/Reveal").show()
	index = 2

func _on_Hide_pressed(): # On a choisi de cacher
	bool_action = -1
	get_node("play").popup_hide()
	get_node("play/VBoxContainer/Card_Select/Carte1").set_pressed(false) # Important, comme on ne fait
	get_node("play/VBoxContainer/Card_Select/Carte2").set_pressed(false) # que cacher, il serait encore séléctionné sinon
	get_node("play/VBoxContainer/Card_Select/Carte3").set_pressed(false) # il faut donc désélctionner

func _on_Reveal_pressed():
	bool_action = 1
	get_node("play").popup_hide()
	get_node("play/VBoxContainer/Card_Select/Carte1").set_pressed(false)
	get_node("play/VBoxContainer/Card_Select/Carte2").set_pressed(false)
	get_node("play/VBoxContainer/Card_Select/Carte3").set_pressed(false)

func _on_ButtonIntro_pressed(): # On veut afficher l'intro
	get_node("Scores").hide()
	if(introduction_is_hidden== true):
		get_node("Introduction").show()
		introduction_is_hidden= false
		if(solution_is_hidden== false): # Si la solutione st affichée on la masque
				get_node("Solution").hide()
				solution_is_hidden= true
	else:
		get_node("Introduction").hide()
		introduction_is_hidden= true
#Question 1
func _on_CheckBox_pressed():
	answers[0] = 1
	pressed_answers+=1
func _on_CheckBox2_pressed():
	answers[0] = 2
	pressed_answers+=1
func _on_CheckBox3_pressed():
	answers[0] = 3
	pressed_answers+=1
func _on_CheckBox4_pressed():
	answers[0] = 4
	pressed_answers+=1

#Question 2
func _on_CheckBox8_pressed():
	answers[1] = 1
	pressed_answers+=1
func _on_CheckBox7_pressed():
	answers[1] = 2
	pressed_answers+=1
func _on_CheckBox6_pressed():
	answers[1] = 3
	pressed_answers+=1
func _on_CheckBox5_pressed():
	answers[1] = 4
	pressed_answers+=1


func _on_CheckBox12_pressed():
	answers[2] = 1
	pressed_answers+=1
func _on_CheckBox11_pressed():
	answers[2] = 2
	pressed_answers+=1
func _on_CheckBox10_pressed():
	answers[2] = 3
	pressed_answers+=1
func _on_CheckBox9_pressed():
	answers[2] = 4
	pressed_answers+=1
	
func _on_CheckBox16_pressed():
	answers[3] = 1
	pressed_answers+=1
func _on_CheckBox15_pressed():
	answers[3] = 2
	pressed_answers+=1
func _on_CheckBox14_pressed():
	answers[3] = 3
	pressed_answers+=1
func _on_CheckBox13_pressed():
	answers[3] = 4
	pressed_answers+=1
	
func _on_CheckBox20_pressed():
	answers[4] = 1
	pressed_answers+=1
func _on_CheckBox19_pressed():
	answers[4] = 2
	pressed_answers+=1
func _on_CheckBox18_pressed():
	answers[4] = 3
	pressed_answers+=1
func _on_CheckBox17_pressed():
	answers[4] = 4
	pressed_answers+=1
	
func _on_CheckBox24_pressed():
	answers[5] = 1
	pressed_answers+=1
func _on_CheckBox23_pressed():
	answers[5] = 2
	pressed_answers+=1
func _on_CheckBox22_pressed():
	answers[5] = 3
	pressed_answers+=1
func _on_CheckBox21_pressed():
	answers[5] = 4
	pressed_answers+=1


func _on_CheckBox28_pressed():
	answers[6] = 1
	pressed_answers+=1
func _on_CheckBox27_pressed():
	answers[6] = 2
	pressed_answers+=1
func _on_CheckBox26_pressed():
	answers[6] = 3
	pressed_answers+=1
func _on_CheckBox25_pressed():
	answers[6] = 4
	pressed_answers+=1


func _on_CheckBox32_pressed():
	answers[7] = 1
	pressed_answers+=1
func _on_CheckBox31_pressed():
	answers[7] = 2
	pressed_answers+=1
func _on_CheckBox30_pressed():
	answers[7] = 3
	pressed_answers+=1
func _on_CheckBox29_pressed():
	answers[7] = 4
	pressed_answers+=1


func _on_CheckBox36_pressed():
	answers[8] = 1
	pressed_answers+=1
func _on_CheckBox35_pressed():
	answers[8] = 2
	pressed_answers+=1
func _on_CheckBox34_pressed():
	answers[8] = 3
	pressed_answers+=1
func _on_CheckBox33_pressed():
	answers[8] = 4
	pressed_answers+=1


func _on_CheckBox40_pressed():
	answers[9] = 1
	pressed_answers+=1
func _on_CheckBox39_pressed():
	answers[9] = 2
	pressed_answers+=1
func _on_CheckBox38_pressed():
	answers[9] = 3
	pressed_answers+=1
func _on_CheckBox37_pressed():
	answers[9] = 4
	pressed_answers+=1


func _on_ButtonSubmit_pressed(): # On soumet les réponses au question 
	if(pressed_answers==10):
		var control  = global.controlGameNode
		var reponse = ""
		for i in range(10):
			reponse+= str(answers[i])+" "
		control.send_mess("Q "+str(control.id_joueur)+" " + reponse)
		get_node("Questionnaire").hide()
		get_node("Patientez").show()
	else:
		print("vous n'avez pas répondu à toutes les questions")
		
		
func _on_ButtonSolu_pressed(): #Permet d'afficher la solution
	get_node("Scores").hide()
	if(solution_is_hidden== true): 
		get_node("Solution").show()
		solution_is_hidden= false
		if(introduction_is_hidden==false): # Fait disparaitre l'intro pour pas de superposition
			get_node("Introduction").hide()
			introduction_is_hidden= true
	else:
		get_node("Solution").hide()
		solution_is_hidden = true
