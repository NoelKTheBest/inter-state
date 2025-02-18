extends Label

@export var actionlist: Node

signal selection_made(option)

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
var current_selection
var selection_count: int = 0
var fi: int = 0
var char1_selection
var char2_selection

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	file = FileAccess.open("res://Dialog/DialogMenus/characteractionmenu.txt", FileAccess.READ)
	text = file.get_as_text()
	fi = 0


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
			current_selection = "char1"
		elif fi == 1:
			format[first_selection] = ' '
			format[second_selection] = '<'
			current_selection = "char2"
		
		text = file.get_as_text() % format
		
		if Input.is_action_just_pressed("select"):
			actionlist.visible = true
		
		if Input.is_action_just_pressed("ui_cancel"):
			actionlist.visible = false
			if current_selection == "char1" and char1_selection != null:
				char1_selection == null
				$Label1.text = ""
				selection_count -= 1
			elif current_selection == "char2" and char2_selection != null:
				char2_selection == null
				$Label2.text = ""
				selection_count -= 1
		
		#if char1_selection == "Drive" or char2_selection == "Drive":
		#	print(actionlist.set_item_text(0, "Rest"))


func _on_visibility_changed() -> void:
	text = file.get_as_text() % format
	first_selection = format.find(' ')
	second_selection = format.find(' ', first_selection + 1)


func _on_item_list_2_item_activated(index: int) -> void:
	print(index)
	match index:
		0:
			if current_selection == "char1" and char1_selection == null:
				char1_selection = "Drive" if char1_selection != "Drive" else "Ride"
				$Label1.text = char1_selection
				selection_count += 1
			elif current_selection == "char2"  and char2_selection == null:
				char2_selection = "Drive" if char1_selection != "Drive" else "Ride"
				$Label2.text = char2_selection
				selection_count += 1
			
			actionlist.visible = false
			
			if selection_count == 2: selection_made.emit("Drive")
		1:
			if current_selection == "char1":
				char1_selection = "Sleep"
				$Label1.text = char1_selection
				selection_count += 1
			elif current_selection == "char2":
				char2_selection = "Sleep"
				$Label2.text = char2_selection
				selection_count += 1
			
			actionlist.visible = false
			
			if selection_count == 2: selection_made.emit("Sleep")
		2:
			if current_selection == "char1": 
				char1_selection = "Explore"
				$Label1.text = char1_selection
				selection_count += 1
			elif current_selection == "char2":
				char2_selection = "Explore"
				$Label2.text = char2_selection
				selection_count += 1
			
			actionlist.visible = false
			
			if selection_count == 2: selection_made.emit("Explore")
