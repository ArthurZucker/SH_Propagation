extends Spatial

var myMeshResource
var spatialNode

var cardNames=["res://00rv.jpg", "res://01rv.jpg","res://02rv.jpg","res://03rv.jpg","res://04rv.jpg",
"res://05rv.jpg", "res://06rv.jpg","res://07rv.jpg","res://08rv.jpg","res://09rv.jpg",
"res://10rv.jpg", "res://11rv.jpg","res://12rv.jpg","res://13rv.jpg",]

var clueNames=["res://i00rv.jpg", "res://i01rv.jpg","res://i02rv.jpg","res://i03rv.jpg","res://i04rv.jpg",
"res://i05rv.jpg", "res://i06rv.jpg","res://i07rv.jpg","res://i08rv.jpg","res://i09rv.jpg",
"res://i10rv.jpg", "res://i11rv.jpg","res://i12rv.jpg","res://i13rv.jpg",
]

var clueCounterNames=[
"res://indice0rv.jpg", "res://indice1rv.jpg", "res://indice2rv.jpg", "res://indice3rv.jpg", "res://indice4rv.jpg",
]

var timeCounterNames=[
"res://temps0rv.jpg", "res://temps1rv.jpg", "res://temps2rv.jpg", "res://temps3rv.jpg", "res://temps4rv.jpg", "res://temps5rv.jpg",
"res://temps6rv.jpg", "res://temps7rv.jpg", "res://temps8rv.jpg", "res://temps9rv.jpg",
]

var resNames=[
"res://res-3rv.jpg", "res://res-2rv.jpg","res://res-1rv.jpg","res://res+0rv.jpg", 
"res://res+1rv.jpg", "res://res+2rv.jpg","res://res+3rv.jpg", 
]

var cardNodes=[
	null, null, null, null, null,
	null, null, null, null, null,
	null, null, null, null,]

var clueNodes=[
	null, null, null, null, null,
	null, null, null, null, null,
	null, null, null, null,]

var clueCounterNodes=[
	null, null, null, null,null,
]

var timeCounterNodes=[
	null, null, null, null,null,
	null, null, null, null,null,
]

var resNodes=[
	null, null, null, null,null,
	null, null, null, null,null,
	null, null, null, null,
]

var clueCounter
var timeCounter

# Called when the node enters the scene tree for the first time.
func _ready():
	spatialNode=get_tree().get_root().get_node("Control").get_node("Spatial")
	myMeshResource = load("res://MyMesh.gd")
	
	cardNodes[1]=createBig(-15,0,0,0,cardNames[1])
	cardNodes[2]=createBig(-12.5,0,0,0,cardNames[2])
	cardNodes[3]=createBig(-10,0,0,0,cardNames[3])
	cardNodes[4]=createBig(-7.5,0,0,0,cardNames[4])
	cardNodes[5]=createBig(-5,0,0,0,cardNames[5])
	cardNodes[6]=createBig(-2.5,0,0,0,cardNames[6])
	cardNodes[7]=createBig(0,0,0,0,cardNames[7])
	cardNodes[8]=createBig(2.5,0,0,0,cardNames[8])
	cardNodes[9]=createBig(5,0,0,0,cardNames[9])
	cardNodes[10]=createBig(7.5,0,0,0,cardNames[10])
	cardNodes[11]=createBig(10,0,0,0,cardNames[11])
	cardNodes[12]=createBig(12.5,0,0,0,cardNames[12])
	cardNodes[13]=createBig(15,0,0,0,cardNames[13])

	var posCluez=2.2
	clueNodes[1]=createSmall(-15,0,posCluez,0,clueNames[1])
	clueNodes[2]=createSmall(-12.5,0,posCluez,0,clueNames[2])
	clueNodes[3]=createSmall(-10,0,posCluez,0,clueNames[3])
	clueNodes[4]=createSmall(-7.5,0,posCluez,0,clueNames[4])
	clueNodes[5]=createSmall(-5,0,posCluez,0,clueNames[5])
	clueNodes[6]=createSmall(-2.5,0,posCluez,0,clueNames[6])
	clueNodes[7]=createSmall(0,0,posCluez,0,clueNames[7])
	clueNodes[8]=createSmall(2.5,0,posCluez,0,clueNames[8])
	clueNodes[9]=createSmall(5,0,posCluez,0,clueNames[9])
	clueNodes[10]=createSmall(7.5,0,posCluez,0,clueNames[10])
	clueNodes[11]=createSmall(10,0,posCluez,0,clueNames[11])
	clueNodes[12]=createSmall(12.5,0,posCluez,0,clueNames[12])
	clueNodes[13]=createSmall(15,0,posCluez,0,clueNames[13])

	var posClueCountery=0.0
	var posClueCounterz=0.7
	clueCounterNodes[4]=createSmall(-18,posClueCountery,posClueCounterz,0,clueCounterNames[4])
	posClueCountery+=0.02
	clueCounterNodes[3]=createSmall(-18,posClueCountery,posClueCounterz,0,clueCounterNames[3])
	posClueCountery+=0.02
	clueCounterNodes[2]=createSmall(-18,posClueCountery,posClueCounterz,0,clueCounterNames[2])
	posClueCountery+=0.02
	clueCounterNodes[1]=createSmall(-18,posClueCountery,posClueCounterz,0,clueCounterNames[1])
	posClueCountery+=0.02
	clueCounter=1
	
	var posTimeCountery=0.0
	var posTimeCounterz=-0.7
	timeCounterNodes[9]=createSmall(-18,posTimeCountery,posTimeCounterz,0,timeCounterNames[9])
	posTimeCountery+=0.02
	timeCounterNodes[8]=createSmall(-18,posTimeCountery,posTimeCounterz,0,timeCounterNames[8])
	posTimeCountery+=0.02
	timeCounterNodes[7]=createSmall(-18,posTimeCountery,posTimeCounterz,0,timeCounterNames[7])
	posTimeCountery+=0.02
	timeCounterNodes[6]=createSmall(-18,posTimeCountery,posTimeCounterz,0,timeCounterNames[6])
	posTimeCountery+=0.02
	timeCounterNodes[5]=createSmall(-18,posTimeCountery,posTimeCounterz,0,timeCounterNames[5])
	posTimeCountery+=0.02
	timeCounterNodes[4]=createSmall(-18,posTimeCountery,posTimeCounterz,0,timeCounterNames[4])
	posTimeCountery+=0.02
	timeCounterNodes[3]=createSmall(-18,posTimeCountery,posTimeCounterz,0,timeCounterNames[3])
	posTimeCountery+=0.02
	timeCounterNodes[2]=createSmall(-18,posTimeCountery,posTimeCounterz,0,timeCounterNames[2])
	posTimeCountery+=0.02
	timeCounterNodes[1]=createSmall(-18,posTimeCountery,posTimeCounterz,0,timeCounterNames[1])
	posTimeCountery+=0.02
	timeCounter=1

func createBig(x,y,z,rv,cname):
	# Create a new card instance
	var mi=myMeshResource.new()
	# and translate it to its final position
	mi.set_translation(Vector3(x,y,z))
	if (rv==1):
		mi.set_rotation(Vector3(0,0,PI))
	# load the tile mesh
	var meshObj=load("res://carte02.obj")
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

func revealClue(v):
	var mesh=clueNodes[v]
	mesh._setEndPosition(clueNodes[v].get_translation())
	mesh.toBeMoved=1
	mesh.flip=1

func moveCardCounter(v):
	var mesh=timeCounterNodes[timeCounter]
	var timePos=Vector3((v-7)*2.5,0,-2.2)
	mesh._setEndPosition(timePos)
	mesh.toBeMoved=1
	timeCounter+=1

func moveClueCounter(v):
	var mesh=clueCounterNodes[clueCounter]
	var cluePos=Vector3((v-7)*2.5,0,3.5)
	mesh._setEndPosition(cluePos)
	mesh.toBeMoved=1
	clueCounter+=1

func createScore(v,v1):
	resNodes[v]=createSmall((v-7)*2.5,0,-3.5,1,resNames[v1])

