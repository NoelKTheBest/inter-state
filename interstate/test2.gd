extends Node

var a = "this might be how i do this"
var b = "i will be able to set it up much easier"
var c = "now i need to figure something out for menus"
var dialog = [a, b, c]

var i: int = 0
var m: int = 0
@export var modvar = 2
var x: int = 0
var mstring


func _process(delta: float) -> void:
	if i <= dialog.size() - 1: mstring = dialog[i].substr(0, x)
	else: mstring = ""
	m += 1
	if m % modvar == 0: x += 1
	
	$Label.text = mstring


func _on_timer_timeout() -> void:
	i += 1
	x = 0
	if i <= dialog.size() - 1: $Timer.start(2)
