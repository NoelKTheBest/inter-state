extends Label

signal selection_made

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


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(format.find(" "))
	if Input.is_action_pressed("ui_up"):
		print("↑")
		# decrement index
	elif Input.is_action_pressed("ui_down"):
		print("↓")
		# increment index


func _on_visibility_changed() -> void:
	print(str(tm) + " set!")
	text = file.get_as_text() % format
