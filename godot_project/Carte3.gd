extends TextureButton

func _ready():
	var root = get_tree().get_root().get_node("ControlGame")
	if(root.my_cards[2] != null):
		var texture=ImageTexture.new()
		texture.load(global.cardNames2[root.my_cards[2]-1])
		texture.set_size_override(Vector2(20, 20))
		get_node("TextureRect").set_expand(true)
		get_node("TextureRect").set_stretch_mode(1)
		get_node("TextureRect").set_texture(texture)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func draw():
	var root = get_tree().get_root().get_node("ControlGame")
	if(root.my_cards[2] != null):
		var texture=ImageTexture.new()
		texture.load(global.cardNames2[root.my_cards[2]-1])
		print("setting tewture : "+str(global.cardNames2[root.my_cards[2]-1]))
		texture.set_size_override(Vector2(20, 20))
		get_node("TextureRect").set_expand(true)
		get_node("TextureRect").set_stretch_mode(1)
		get_node("TextureRect").set_texture(texture)
