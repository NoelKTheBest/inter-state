extends Label

var dialog = []
var i: int = 0
var m: int = 0
@export var modvar = 2
var x: int = 0
var mstring

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dialog.append("d_Hey Sheen, we need to make a stop for gas.")
	dialog.append("s_Yeah that sounds like a good idea.")
	dialog.append("s_Besides, we could use some more money.")
	dialog.append("d_Let's do it, I need to take a piss anyways.")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if i <= dialog.size() - 1: mstring = dialog[i].substr(0, x)
	else: mstring = ""
	m += 1
	if m % modvar == 0: x += 1
	
	text = mstring


func _on_timer_timeout() -> void:
	i += 1
	x = 0
	if i <= dialog.size() - 1: $Timer.start(2)
