extends Spatial
# Pour gerer la partie graphique
# A modifier
var myMeshResource
var spatialNode

var cardNames=[	"Images/carte01.jpg","Images/carte02.jpg","Images/carte03.jpg","Images/carte04.jpg",
				"Images/carte05.jpg","Images/carte06.jpg","Images/carte07.jpg","Images/carte08.jpg",
				"Images/carte09.jpg","Images/carte10.jpg","Images/carte11.jpg","Images/carte12.jpg",
				"Images/carte13.jpg","Images/carte14.jpg","Images/carte15.jpg","Images/carte16.jpg",
				"Images/carte17.jpg","Images/carte18.jpg","Images/carte19.jpg","Images/carte20.jpg",
				"Images/carte21.jpg","Images/carte22.jpg","Images/carte23.jpg","Images/carte24.jpg",
				"Images/carte25.jpg","Images/carte26.jpg","Images/carte27.jpg","Images/carte28.jpg",
				"Images/carte29.jpg","Images/carte30.jpg","Images/carte31.jpg","Images/carte32.jpg",
				]

var cardNodes=[
	null, null, null, null, null,
	null, null, null, null, null,
	null, null, null, null, null,
	null, null, null, null, null,
	null, null, null, null, null,
	null, null, null, null, null,
	null, null, null, null, null,
	null, null]


func _ready():
	pass
# Called when the node enters the scene tree for the first time.
#func _ready():
#	spatialNode=get_tree().get_root().get_node("ControlGame").get_node("Spatial")#récupere un pointeur vers le noeud spatiale
#	myMeshResource = load("res://MyMesh.gd")#charge pointeur sur la classe
#
#	for j in range(len(cardNames)):
#		var i = global.controlGameNode.shuffle[j]
#		cardNodes[j]=createBig((randf() * (0.1)) -0.05,0.05*i,-40,(randf() * (0.2)) -0.1,cardNames[i])

func _create():
	spatialNode=get_tree().get_root().get_node("ControlGame").get_node("Spatial")#récupere un pointeur vers le noeud spatiale
	myMeshResource = load("res://MyMesh.gd")#charge pointeur sur la classe
	print("len cardnames "+str(len(cardNames)))
	for j in range(len(cardNames)):
		print(j)
		print("shuffle[j]"+str(global.controlGameNode.shuffle[j]))
		var i = global.controlGameNode.shuffle[j]
		cardNodes[j]=createBig((randf() * (0.1)) -0.05,0.05*j,-40,(randf() * (0.2)) -0.1,cardNames[i])

func createBig(x,y,z,rv,cname):
	# Create a new card instance
	var mi=myMeshResource.new()
	# and translate it to its final position
	mi.set_translation(Vector3(x,y,z))
	if (rv==1):
		mi.set_rotation(Vector3(0,0,PI))
	else:
		mi.set_rotation(Vector3(0,rv,0)) #petite rotation pour l'effet de carte
		mi.set_rotation(Vector3(0,0,PI))
	# load the tile mesh
	var meshObj=load("res://final_carde005.obj")
	# and assign the mesh instance with it
	mi.mesh=meshObj
	# create a new spatial material for the tile
	var surface_material=SpatialMaterial.new()
	# and assign the material to the mesh instance
	mi.set_surface_material(0,surface_material)
	surface_material.albedo_texture=load(cname)
	spatialNode.add_child(mi)
	return mi

func revealCard(num_card):
	var mesh=cardNodes[num_card-1]
	mesh.set_rotation(Vector3(0,0,0))
	mesh._setEndPosition(global.pos_reveal_card+Vector3(0,0,global.controlGameNode.cpt_card_reveal*5))#0.3
	mesh.toBeMoved=1
	mesh.flip=0

func hideCard(num_card):
	var mesh=cardNodes[num_card-1]
	mesh.set_rotation(Vector3(0,0,0))
	mesh._setEndPosition(global.pos_hide_card+Vector3(0,global.controlGameNode.cpt_card_hide*0.1,0))
	mesh.toBeMoved=1
	mesh.flip=1
	
func handCard(data):
	var id_player = data[0]
	for i in range(3):
		var num_card = data[i+1]
		var mesh=cardNodes[num_card-1]
		mesh._setEndPosition(global.pos[id_player]+Vector3(0,0,i*5))
		mesh.toBeMoved=1
		if(id_player==1 || id_player==3):
			mesh.flip=1
			mesh.set_rotation(Vector3(0,0,1.5))
		else:
			mesh.flip=0
			mesh.set_rotation(Vector3(0,3.2,-1.5))
		
func drawCard(data,empty_hand):
	var id_player = data[0]
	var num_card = data[1]
	var mesh=cardNodes[num_card-1]
	mesh._setEndPosition(global.pos[id_player]+Vector3(0,0,empty_hand*5))
	mesh.toBeMoved=1
	if(id_player==1 || id_player==3):
		mesh.flip=1
		mesh.set_rotation(Vector3(0,0,1.5))
	else:
		mesh.flip=0
		mesh.set_rotation(Vector3(0,3.2,-1.5))

