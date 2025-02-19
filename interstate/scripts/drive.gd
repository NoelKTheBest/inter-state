extends Sprite2D

@export var spd = 10
var currspd: int = 0
var wheel1: Node
var wheel2: Node
var angspd: float
var angrot: float
@export var wheelrad: float = 0.203 # value in meters


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	wheel1 = $Wheel1
	wheel2 = $Wheel2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_right"):
		move_local_x(1*spd)
		currspd = spd
	elif Input.is_action_pressed("ui_left"):
		move_local_x(-1*spd)
		currspd = spd * -1
	else:
		currspd = 0
	
	angspd = currspd / wheelrad
	angrot = angspd * delta
	wheel1.rotate(angrot)
	wheel2.rotate(angrot)
