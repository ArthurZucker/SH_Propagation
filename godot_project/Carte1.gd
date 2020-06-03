extends TextureButton


func _ready():
	rect_size = Vector2(100,200)
	var root = get_tree().get_root().get_node("ControlGame")
	print("mycards[i] = "+str(root.my_cards[0] ))
	if(root.my_cards[0] != null):
		var cname = global.cardNames2[root.my_cards[0]-1]
		var img = Image.new()
		var itex = ImageTexture.new()
		img.load(cname)
		itex.create_from_image(img)
		#var tex=ImageTexture.new()
		#tex.load(cname)
		#set_expand(true)
		#set_stretch_mode(STRETCH_KEEP_ASPECT_CENTERED)
		set_normal_texture(itex)
		texture_normal = itex
	show()
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func draw():
	var root = get_tree().get_root().get_node("ControlGame")
	#print("mycards[i] = "+str(root.my_cards[0] ))
	if(root.my_cards[0] != null):
		var cname = global.cardNames2[root.my_cards[0]-1]
		var img = Image.new()
		var itex = ImageTexture.new()
		img.load(cname)
		itex.create_from_image(img)
		#var tex=ImageTexture.new()
		#tex.load(cname)
		#set_expand(true)
		#set_stretch_mode(STRETCH_KEEP_ASPECT_CENTERED)
		set_normal_texture(itex)
		texture_normal = itex
		
