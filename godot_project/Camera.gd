extends Camera
# ne pas modifier ici. 
# Pour les deplacement de la camera à l'aide d'un joystick
var coef=15.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.get_connected_joypads().size() > 0:
		var xAxis = Input.get_joy_axis(0,JOY_AXIS_0)
		var zAxis = Input.get_joy_axis(0,JOY_AXIS_1)
		#print (abs(xAxis), abs(zAxis))
		if abs(xAxis)>0.1:
			translation.x+=delta * xAxis * coef
		if abs(zAxis)>0.1:
			translation.z+=delta * zAxis * coef

		var xAxis1 = Input.get_joy_axis(0,JOY_AXIS_2)
		var zAxis1 = Input.get_joy_axis(0,JOY_AXIS_3)
		if abs(xAxis1)>0.1:
			translation.y+=delta * xAxis1 * coef
#       pass
