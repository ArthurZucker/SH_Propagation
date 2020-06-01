extends Node2D

var frankieFont
var frankieFont14
var edoFont30

var spriteNode
var scoreNode

# Called when the node enters the scene tree for the first time.
func _ready():
	
	spriteNode=$Sprite
	scoreNode=$Score
	
	print ("spriteNode=",spriteNode)
	frankieFont=DynamicFont.new()
	frankieFont.font_data = load("res://font/Frankie.otf")
	frankieFont.size = 20
	frankieFont.use_filter = true
	
	frankieFont14=DynamicFont.new()
	frankieFont14.font_data = load("res://font/Frankie.otf")
	frankieFont14.size = 14
	frankieFont14.use_filter = true

	edoFont30=DynamicFont.new()
	edoFont30.font_data = load("res://font/edo.ttf")
	edoFont30.size = 28
	edoFont30.use_filter = true

	print ("Dialog _ready() done")
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func displayDialog(v):
	if v==1:
		show()
	else:
		hide()

func createSprite(texture,pos):
	var sp=Sprite.new()
	sp.set_position(pos)
	sp.texture=texture
	spriteNode.add_child(sp)

func createLabel20(txt, pos):
	var line=Label.new()
	line.set_text(txt)
	line.add_font_override("font", frankieFont)
	line.add_color_override("font_color", Color(0,0,0))
	line.set_position(pos)
	#print (line.get_size())
	spriteNode.add_child(line)

func createLabel(txt, pos):
	var line=Label.new()
	line.set_text(txt)
	line.add_font_override("font", frankieFont14)
	line.add_color_override("font_color", Color(0,0,0))
	line.set_position(pos)
	spriteNode.add_child(line)

func createLabelEDO30(txt, pos):
	var line=Label.new()
	line.set_text(txt)
	line.add_font_override("font", edoFont30)
	#line.add_color_override("font_color", Color(0,0,0))
	line.set_position(pos)
	#print (line.get_size())
	scoreNode.add_child(line)

func createScore(s0,sp0,s1,sp1,s2,sp2,s3,sp3):
	
	for i in range(0, scoreNode.get_child_count()):
		scoreNode.get_child(i).queue_free()
		
	print (s0," ",sp0," ",s1," ",sp1," ",s2," ",sp2," ",s3," ",sp3)
	var sc=s0+'\n'+sp0+'\n\n'+s1+'\n'+sp1+'\n\n'+s2+'\n'+sp2+'\n\n'+s3+'\n'+sp3
	createLabelEDO30(sc,Vector2(-10,-200))	
