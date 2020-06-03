extends TextureButton


func _ready():
	var root = get_tree().get_root().get_node("ControlGame")
	print("mycards[i] = "+str(root.my_cards[0] ))
	if(root.my_cards[0] != null):
		var texture=ImageTexture.new()
		texture.load(global.cardNames2[root.my_cards[0]])
		print("setting texture : "+global.cardNames2[root.my_cards[0]])
		set_normal_texture(texture)
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func draw():
	var root = get_tree().get_root().get_node("ControlGame")
	#print("mycards[i] = "+str(root.my_cards[0] ))
	if(root.my_cards[0] != null):
		print("my card not null redrawing texture card 0")
		var texture=ImageTexture.new()
		texture.load(global.cardNames2[root.my_cards[0]])
		print("setting tewture : "+global.cardNames2[root.my_cards[0]])
		set_normal_texture(texture)
