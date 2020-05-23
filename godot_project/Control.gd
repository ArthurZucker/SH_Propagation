extends Control
# pour gerer le jeu
# modifier les 'if mess' pour les actions (dans le while)
var spatialNode
var thread
var server

# Called when the node enters the scene tree for the first time.
func _ready():
	spatialNode=get_tree().get_root().get_node("Control").get_node("Spatial")
	print ("spatialNode=",spatialNode)

	thread = Thread.new()
	thread.start(self, "_thread_function", "networkThread")
	pass # Replace with function body.

func _thread_function(userdata):
	print("I'm a thread! Userdata is: ", userdata)
	var done = false
	var port = 4242

	server = TCP_Server.new()
	if server.listen( port ) == 0:
		print( "Server started on port "+str(port) )
		set_process( true )
	else:
		print( "Failed to start server on port "+str(port) )

	while(done != true):
		if server.is_connection_available():
			print("connection")
			var client = server.take_connection()
			var availableBytes=client.get_available_bytes()
			var data = client.get_data(availableBytes)
			print (data[0]," ",data[1].get_string_from_ascii())
			var mess=data[1].get_string_from_ascii()
			if (mess[0]=='R'):
				print ("message REVEAL")
				var d=int(mess[1])
				var u=int(mess[2])
				var v=d*10+u
				print ("R",v)
				spatialNode.revealCard(v)
				spatialNode.moveCardCounter(v)
			elif (mess[0]=='H'):
				print ("message HIDE")
				var d=int(mess[1])
				var u=int(mess[2])
				var v=d*10+u
				print ("H",v)
				spatialNode.hideCard(v)
				spatialNode.moveHideCounter(v)
			elif (mess[0]=='S'):
				print ("message SCORE")
				var d=int(mess[1])
				var u=int(mess[2])
				var v=d*10+u
				print ("S",v)
				var d1=int(mess[3])
				var u1=int(mess[4])
				var v1=d1*10+u1
				spatialNode.createScore(v,v1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
