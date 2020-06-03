extends TextureButton


func _ready():
	rect_size = Vector2(100,200)
	var root = get_tree().get_root().get_node("ControlGame")
	print("mycards[i] = "+str(root.my_cards[0] ))
	if(root.my_cards[0] != null):
		var texture=ImageTexture.new()
		texture.load(global.cardNames2[root.my_cards[0]-1])
		print("setting texture : "+str(global.cardNames2[root.my_cards[0]-1]))
		texture.set_size_override(Vector2(20, 20))
		set_normal_texture(texture)
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func draw():
	var root = get_tree().get_root().get_node("ControlGame")
	#print("mycards[i] = "+str(root.my_cards[0] ))
	if(root.my_cards[0] != null):
		print("my card not null redrawing texture card 0")
		var texture=ImageTexture.new()
		texture.load(global.cardNames2[root.my_cards[0]-1])
		print("setting tewture : "+str(global.cardNames2[root.my_cards[0]-1]))
		texture.set_size_override(Vector2(20, 20))
		set_normal_texture(texture)
