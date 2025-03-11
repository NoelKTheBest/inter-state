extends Label

@export var actionlist: Node

signal transition()

var tm
var ts
var tmot
var char1
var char2
var gas

var format = []
var file


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	file = FileAccess.open("res://Dialog/DialogMenus/characteractionmenu.txt", FileAccess.READ)
	text = file.get_as_text()

func _on_visibility_changed() -> void:
	var formatted_text = file.get_as_text() % format
	text = formatted_text
