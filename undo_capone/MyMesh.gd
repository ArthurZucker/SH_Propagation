extends MeshInstance

class_name MyMesh, "res://icon.png"

var toBeMoved
var lt
var pStart
var pEnd
var pMiddle
var aStart
var flip

# Called when the node enters the scene tree for the first time.
func _ready():
	toBeMoved=0
	lt=0.0
	flip=0
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if toBeMoved==1:
		lt+=delta
		if flip==0:
			_moveFromTo(lt)
		else:
			_moveFromToFlip(lt)
		if lt>1.0:
			lt=1.0
			if flip==0:
				_moveFromTo(lt)
			else:
				_moveFromToFlip(lt)
			toBeMoved=0
			print(get_translation()," ",get_rotation())
			lt=0.0	
#	pass

func _setEndPosition(v):
	pStart=get_translation()
	pEnd=v
	pMiddle=Vector3((pStart.x+pEnd.x)/2.0,5.0,(pStart.z+pEnd.z)/2.0)
	aStart=get_rotation()
	
func _moveFromToFlip(lt):
	var q0=pStart.linear_interpolate(pMiddle,lt)
	var q1=q0.linear_interpolate(pEnd,lt)
	set_translation(q1)
	set_rotation(Vector3(0,0,aStart.z).linear_interpolate(Vector3(0,0,aStart.z-PI), lt))

func _moveFromTo(lt):
	var q0=pStart.linear_interpolate(pMiddle,lt)
	var q1=q0.linear_interpolate(pEnd,lt)
	set_translation(q1)
