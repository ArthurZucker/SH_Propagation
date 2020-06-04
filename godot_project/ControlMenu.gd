extends Control

var networkThread
var socket
var port
var player_name
# Called when the node enters the scene tree for the first time.
func _ready():
	createNetworkThread()
	pass

func createNetworkThread():
	networkThread=Thread.new()
	networkThread.start(self, "_thread_network_function", "networkThread")

func _thread_network_function(userdata):
	var done=false
	socket = PacketPeerUDP.new()
	port = 4010
	if (socket.listen(port,"127.0.0.1") != OK):
		print("An error occurred listening on port " +str(port))
		done = true;
	else:
		print("Listening on port" +str(port)+ "on 127.0.0.1")
	while (done!=true):
		if(socket.get_available_packet_count() > 0):
			var data = socket.get_packet().get_string_from_ascii()
			print("Data received: " + data)
			global.controlGameNode._networkMessage(data)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_ButtonJouer_pressed():
	player_name = "Sud"
	var root=get_tree().get_root()
	var myself=root.get_child(1)
	print (root,myself)
	root.remove_child(myself)
	root.add_child(global.controlGameNode)
	var connectMessage="C "+str(global.direction)+" " + str(port)+ " "+player_name
	socket.set_dest_address("127.0.0.1", 4242)
	socket.put_packet(connectMessage.to_ascii())


func _on_ButtonOptions_pressed():
	var root=get_tree().get_root()
	var myself=root.get_child(1)
	print (root,myself)
	root.remove_child(myself)
	root.add_child(global.controlOptionsNode)

func _on_ButtonTestReseau_pressed():
	print ("sending UDP test data to  127.0.0.1 port 4242")
	socket.set_dest_address("127.0.0.1", 4242)
	socket.put_packet("lalala".to_ascii())
#192.168.1.75
