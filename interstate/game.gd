extends Node

var total_money
var total_sleep
var total_motivation
var gasoline

var no_money: bool = false
var is_everyone_tired: bool = false
var no_motivation: bool = false
var on_E: bool = false

var str = "hello world. Welcome to Interstate.\nThe game where you simulate the experience of being on a roadtrip."


var game_over_scenarios = ['BROKE', 'TIRED', 'BORED', 'E', 'CRASH']

var screen: Node
var timer: Node
var quickselect: Node

var character_scene: PackedScene = preload("res://character.tscn")
var char1
var char2

var char_toggle = 0
var dialog = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen = $TextScreen
	timer = $TextScreen/Timer
	quickselect = $TextScreen/QuickSelect
	
	var file = FileAccess.open("res://Dialog/Game_Start.txt", FileAccess.READ)
	while file.eof_reached() != true:
		dialog.append(file.get_line())
	
	screen.text = dialog[0]
	
	char1 = character_scene.instantiate()
	char2 = character_scene.instantiate()
	create_char(char1, "Sheen", 100, 10, 87)
	create_char(char2, "Shareen", 100, 14, 66)
	
	total_money = char1.money + char2.money
	total_sleep = char1.sleep + char2.sleep
	total_motivation = char1.motivation + char2.motivation
	
	dialog[3] = dialog[3] % [total_money, total_sleep, total_motivation]
	dialog[4] = dialog[4] % [5]
	print(dialog)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func procesc(delta: float) -> void:
	
	var name1 = char1.character_name
	var name2 = char2.character_name
	
	if Input.is_action_pressed("ui_up"):
		char_toggle -= 1
		if char_toggle > 0: char_toggle = 0
	
	if Input.is_action_pressed("ui_down"):
		char_toggle += 1
		if char_toggle < 1: char_toggle = 1
	
	if char_toggle == 0:
		name1 = char1.character_name + ' <'
	elif char_toggle == 1:
			name2 = char2.character_name + ' <'


func create_char(character, char_name, money, sleep, motivation):
	character.character_name = char_name
	character.money = money # /1000
	character.sleep = sleep # /16
	character.motivation = motivation # /100


func _on_timer_timeout() -> void:
	pass


func _on_destination_list_item_activated(index: int) -> void:
	$TextScreen/DestinationList.visible = false
