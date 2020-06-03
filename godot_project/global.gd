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
var pos = [Vector3(-20,0,-20),Vector3(20,0,-20),Vector3(-20,0,20),Vector3(20,0,20)] 
var pos_reveal_card = Vector3(0,0,5)
var pos_hide_card = Vector3(0,-0.01,-5)
var previous
var current
var cardNames2 = [	"res://carte01.jpg","res://carte02.jpg","res://carte03.jpg","res://carte04.jpg",
				"res://carte05.jpg","res://carte06.jpg","res://carte07.jpg","res://carte08.jpg",
				"res://carte09.jpg","res://carte10.jpg","res://carte11.jpg","res://carte12.jpg",
				"res://carte13.jpg","res://carte14.jpg","res://carte15.jpg","res://carte16.jpg",
				"res://carte17.jpg","res://carte18.jpg","res://carte19.jpg","res://carte20.jpg",
				"res://carte21.jpg","res://carte22.jpg","res://carte23.jpg","res://carte24.jpg",
				"res://carte25.jpg","res://carte26.jpg","res://carte27.jpg","res://carte28.jpg",
				"res://carte29.jpg","res://carte30.jpg","res://carte31.jpg","res://carte32.jpg",
				]
func _ready():
	direction=0
	print("global _ready() called")
	pass 
