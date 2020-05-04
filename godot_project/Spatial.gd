extends Spatial
# Pour gerer la partie graphique
# A modifier
var myMeshResource
var spatialNode

var cardNames=[	"res://carte01.jpg","res://carte02.jpg","res://carte03.jpg","res://carte04.jpg",
				"res://carte05.jpg","res://carte06.jpg","res://carte07.jpg","res://carte08.jpg",
				"res://carte09.jpg","res://carte10.jpg","res://carte11.jpg","res://carte12.jpg",
				"res://carte13.jpg","res://carte14.jpg","res://carte15.jpg","res://carte16.jpg",
				"res://carte17.jpg","res://carte18.jpg","res://carte19.jpg","res://carte20.jpg",
				"res://carte21.jpg","res://carte22.jpg","res://carte23.jpg","res://carte24.jpg",
				"res://carte25.jpg","res://carte26.jpg","res://carte27.jpg","res://carte28.jpg",
				"res://carte29.jpg","res://carte30.jpg","res://carte33.jpg","res://carte32.jpg",
				]



var cardNodes=[
	null, null, null, null, null,
	null, null, null, null, null,
	null, null, null, null, null,
	null, null, null, null, null,
	null, null, null, null, null,
	null, null, null, null, null,
	null, null, null, null, null,
	null, null, null, null, null,]



# Called when the node enters the scene tree for the first time.
func _ready():
	spatialNode=get_tree().get_root().get_node("Control").get_node("Spatial")#récupere un pointeur vers le noeud spatiale
	myMeshResource = load("res://MyMesh.gd")#charge pointeur sur la classe
	
	for i in range(len(cardNames)):
		cardNodes[i]=createBig(0,0,1*i,(randf() * (0.1)) -0.05,cardNames[i])
	

	

func createBig(x,y,z,rv,cname):
	# Create a new card instance
	var mi=myMeshResource.new()
	# and translate it to its final position
	mi.set_translation(Vector3(x,y,z))
	if (rv==1):
		mi.set_rotation(Vector3(0,0,PI))
	else:
		mi.set_rotation(Vector3(0,rv,0)) #petite rotation pour l'effet de carte
	# load the tile mesh
	var meshObj=load("res://final_carde002.obj")
	# and assign the mesh instance with it
	mi.mesh=meshObj
	# create a new spatial material for the tile
	var surface_material=SpatialMaterial.new()
	# and assign the material to the mesh instance
	mi.set_surface_material(0,surface_material)
	# create a new image texture that will be used as a tile texture
	var texture=ImageTexture.new()
	texture.load(cname)
	# and perform the assignment to the surface_material
	surface_material.albedo_texture=texture
	# add the newly created instance as a child of the Origine3D Node
	spatialNode.add_child(mi)
	return mi
	
func createSmall(x,y,z,rv,cname):
	# Create a new card instance
	var mi=myMeshResource.new()
	# and translate it to its final position
	mi.set_translation(Vector3(x,y,z))
	if (rv==1):
		mi.set_rotation(Vector3(0,0,PI))
	# load the tile mesh
	var meshObj=load("res://indice01.obj")
	# and assign the mesh instance with it
	mi.mesh=meshObj
	# create a new spatial material for the tile
	var surface_material=SpatialMaterial.new()
	# and assign the material to the mesh instance
	mi.set_surface_material(0,surface_material)
	# create a new image texture that will be used as a tile texture
	var texture=ImageTexture.new()
	texture.load(cname)
	# and perform the assignment to the surface_material
	surface_material.albedo_texture=texture
	# add the newly created instance as a child of the Origine3D Node
	spatialNode.add_child(mi)
	return mi

func revealCard(v):
	var mesh=cardNodes[v]
	mesh._setEndPosition(cardNodes[v].get_translation())
	mesh.toBeMoved=1
	mesh.flip=1

