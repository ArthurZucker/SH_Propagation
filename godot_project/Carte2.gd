extends TextureButton


func _ready():
	var root = get_tree().get_root().get_node("ControlGame")
	if(root.my_cards[1] != null):
		var texture=ImageTexture.new()
		texture.load(global.cardNames2[root.my_cards[1]-1])
		set_normal_texture(texture)
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func draw():
	var root = get_tree().get_root().get_node("ControlGame")
	if(root.my_cards[1] != null):
		var texture=ImageTexture.new()
		texture.load(global.cardNames2[root.my_cards[1]-1])
		print("setting tewture : "+str(global.cardNames2[root.my_cards[1]-1]))
		set_normal_texture(texture)
