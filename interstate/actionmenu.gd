extends Label

@export var actionlist: Node

signal selection_made

var tm
var ts
var tmot
var char1
var char2
var gas

var format = []
var file

var first_selection
var second_selection
var fi: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	file = FileAccess.open("res://Dialog/DialogMenus/characteractionmenu.txt", FileAccess.READ)
	text = file.get_as_text()
	print(actionlist)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:	
	if Input.is_action_just_pressed("ui_up"):
		# decrement index
		fi -= 1
	elif Input.is_action_just_pressed("ui_down"):
		# increment index
		fi += 1
	
	fi = clamp(fi, 0, 1)
	
	if visible:
		if fi == 0: 
			format[first_selection] = '<'
			format[second_selection] = ' '
		elif fi == 1:
			format[first_selection] = ' '
			format[second_selection] = '<'
		
		text = file.get_as_text() % format
		
		if Input.is_action_just_pressed("select"):
			actionlist.visible = true
		
		if Input.is_action_just_pressed("ui_cancel"):
			actionlist.visible = false
			


func _on_visibility_changed() -> void:
	text = file.get_as_text() % format
	first_selection = format.find(' ')
	second_selection = format.find(' ', first_selection + 1)


func _on_item_list_2_item_activated(index: int) -> void:
	print(index)
