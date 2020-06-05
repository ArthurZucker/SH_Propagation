extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	global.controlMenuNode=load("res://ControlMenu.tscn").instance()
	global.controlGameNode=load("res://ControlGame.tscn").instance()
	global.controlOptionsNode=load("res://ControlOptions.tscn").instance()
	print("IP:", IP.get_local_addresses())
	global.ipAddress=str(IP.get_local_addresses()[2])
	match global.ipAddress:
		"127.0.0.1":
			global.direction=0
	print ("controlMenuNode=",global.controlMenuNode)
	print ("controlGameNode=",global.controlGameNode)
	print ("controlOptionsNode=",global.controlOptionsNode)
	print (global.ipAddress)
	print (global.direction)
	print (self)
	print ("controlSplash _ready")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ButtonVersMenu_pressed():
	var root=get_tree().get_root()
	var myself=root.get_child(1)
	print (root,myself)
	root.remove_child(myself)
	root.add_child(global.controlMenuNode)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#       pass

