extends Control


func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _networkMessage(mess):
	print ("_networkMessage=",mess)
	match mess[0]:
		'C':
			pass
		'T':
			pass
		'D':
			pass
		'L':
			pass
		'S':
			pass

func _on_ButtonMenu_pressed():
	var root=get_tree().get_root()
	var myself=root.get_child(1)
	print (root,myself)
	root.remove_child(myself)
	root.add_child(global.controlMenuNode)
	
func createTile(x,y,tilenum):
	# Create a new tile instance
	var mi=MeshInstance.new()
	# and translate it to its final position
	mi.set_translation(Vector3(x,0,y))
	# load the tile mesh
	var meshObj=load("res://obj/tile00.obj")
	# and assign the mesh instance with it
	mi.mesh=meshObj
	# create a new spatial material for the tile
	var surface_material=SpatialMaterial.new()
	# and assign the material to the mesh instance
	mi.set_surface_material(0,surface_material)
	# create a new image texture that will be used as a tile texture
	var texture=ImageTexture.new()
	#texture.load(tileNames[tilenum])
	# and perform the assignment to the surface_material
	surface_material.albedo_texture=texture
	# add the newly created instance as a child of the Origine3D Node
	$Spatial.add_child(mi)
	return mi
	
func createExplorer(x,y,num):
	# Create a new tile instance
	var mi=MeshInstance.new()
	# and translate it to its final position
	mi.set_translation(Vector3(x,0,y))
	mi.set_rotation(Vector3(0,PI/2.0,0))
	mi.set_scale(Vector3(0.5,0.5,0.5))
	# load the tile mesh
	var meshObj=load("res://obj/indiana02.obj")
	# and assign the mesh instance with it
	mi.mesh=meshObj
	# create a new spatial material for the tile
	var surface_material=SpatialMaterial.new()
	# set its color
	#surface_material.albedo_color=explorerColor[num]
	# and assign the material to the mesh instance
	mi.set_surface_material(0,surface_material)
	# add the newly created instance as a child of the Origine3D Node
	$Spatial.add_child(mi)
	return mi
