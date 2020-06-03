extends TextureButton


func _ready():
	rect_size = Vector2(100,200)
	var root = get_tree().get_root().get_node("ControlGame")
	print("mycards[i] = "+str(root.my_cards[0] ))
	if(root.my_cards[0] != null):
		var tex=ImageTexture.new()
		tex.load(global.cardNames2[root.my_cards[0]-1])
		print("______________________________")
		print("setting texture : "+str(global.cardNames2[root.my_cards[0]-1]))
		print("______________________________")
		set_expand(true)
		set_stretch_mode(STRETCH_KEEP_ASPECT_CENTERED)
		set_normal_texture(tex)
		print("texture is : ")
		print(get_normal_texture())
		texture_normal = tex
		
		
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func draw():
	var root = get_tree().get_root().get_node("ControlGame")
	#print("mycards[i] = "+str(root.my_cards[0] ))
	if(root.my_cards[0] != null):
		print("my card not null redrawing texture card 0")
		var tex=ImageTexture.new()
		tex.load(global.cardNames2[root.my_cards[0]-1])
		print("______________________________")
		print("setting tewture : "+str(global.cardNames2[root.my_cards[0]-1]))
		print("______________________________")
		set_expand(true)
		set_stretch_mode(STRETCH_KEEP_ASPECT_CENTERED)
		set_normal_texture(tex)
		print("texture is : ")
		print(get_normal_texture())
		texture_normal = tex
		
