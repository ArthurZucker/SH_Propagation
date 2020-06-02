extends Node

var mode
var network
var mplayer

var controlMenuNode
var controlGameNode
var controlOptionsNode
var controlSplashNode
var controlEndGameNode
var controlScoreNode
var ipAddress
var direction
var pos = [Vector3(-10,0,-10),Vector3(10,0,-10),Vector3(-10,0,10),Vector3(10,0,10)] 
var previous
var current

func _ready():
	direction=0
	print("global _ready() called")
	pass 
