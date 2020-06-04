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
var pos = [Vector3(-20,2,-20),Vector3(20,2,-20),Vector3(-20,2,20),Vector3(20,2,20)] 
var pos_reveal_card = Vector3(0,-1.5,-35)
var pos_hide_card = Vector3(0,0,-45)
var previous
var current
var cardNames2 = [	"res://c1.jpg","res://c2.jpg","res://c3.jpg",
					"res://c4.jpg","res://c5.jpg","res://c6.jpg",
					"res://c7.jpg","res://c8.jpg","res://c9.jpg",
					"res://c10.jpg","res://c11.jpg","res://c12.jpg",
					"res://c13.jpg","res://c14.jpg","res://c15.jpg",
					"res://c16.jpg","res://c17.jpg","res://c18.jpg",
					"res://c19.jpg","res://c20.jpg","res://c21.jpg",
					"res://c22.jpg","res://c23.jpg","res://c24.jpg",
					"res://c25.jpg","res://c26.jpg","res://c27.jpg",
					"res://c28.jpg","res://c29.jpg","res://c30.jpg",
					"res://c31.jpg","res://c32.jpg"]






func _ready():
	direction=0
	print("global _ready() called")
	pass 
