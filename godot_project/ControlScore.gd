extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(4):
		var score = global.controlGameNode.scores[i]
		var label = get_child(0).get_child(0).get_child(i)
		var chaine ="Score :"+str(score)+"\n"
		if(score<=6):
			chaine += "Inspecteur Lestrade : vous subirez les moqueries de Sherlock encore un certain temps. Vous devez donc résoudre une nouvelle affaire au plus vite!"
		elif(score<=10):
			chaine += "John Watson : Vous avez résolu l'affaire. Mais avouez que cela n'a pas été sans peine! "
		elif(score<=14):
			chaine += "Irène Adler : Sherlock lui-même est impréssioné par votre génie! Tout le monde ne peut pas en dire autant!"
		elif(score<=17):
			chaine += "Microft Holmes : Ne laissez jamais la réputation de votre frère entacher votre talent. Ce n'est pas pour rien que vous travaillez au services de Sa Majesté"
		elif(score >=18):
			chaine += "Sherlock Holmes : Excellent. Vous êtes son égal."
		label.text=chaine
		
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
