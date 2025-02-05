extends Node

var total_money
var total_sleep
var total_motivation
var gasoline
	# define distances based on gas usage
var gas_needed = [6, 5, 2, 1]

var no_money: bool = false
var is_everyone_tired: bool = false
var no_motivation: bool = false
var on_E: bool = false

var str = "hello world. Welcome to Interstate.\nThe game where you simulate the experience of being on a roadtrip."


var game_over_scenarios = ['BROKE', 'TIRED', 'BORED', 'E', 'CRASH']

var screen: Node
var timer: Node
var action_menu: Node

var character_scene: PackedScene = preload("res://character.tscn")
var char1
var char2

var dialog = []
var di: int = 0

var skip: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Get References
	$TextScreen/AnimationPlayer.play("TypewriterEffect")
	screen = $TextScreen/Label
	timer = $TextScreen/Timer
	action_menu = $TextScreen/CharacterActionMenu
	
	# Load Dialog
	var file = FileAccess.open("res://Dialog/Game_Start.txt", FileAccess.READ)
	while file.eof_reached() != true:
		dialog.append(file.get_line())
	
	# Scene Setup
	screen.text = dialog[di]
	
	char1 = character_scene.instantiate()
	char2 = character_scene.instantiate()
	create_char(char1, "Sheen", 100, 10, 87)
	create_char(char2, "Dwayne", 100, 14, 66)
	
	total_money = char1.money + char2.money
	total_sleep = char1.sleep + char2.sleep
	total_motivation = char1.motivation + char2.motivation
	gasoline = 10
	
	setup_action_menu()
	print(action_menu.format)
	
	dialog[3] = dialog[3] % [total_money, total_sleep, total_motivation]
	dialog[4] = dialog[4] % [5]
	dialog[dialog.size() - 1] = "...."


func _process(delta: float) -> void:
	if di <= dialog.size() - 1:
		if Input.is_action_just_pressed("ui_accept") and not skip:
			#print("skip?")
			$TextScreen/AnimationPlayer.seek(1.75)
			skip = true
		elif Input.is_action_just_pressed("ui_accept") and skip:
			#print("SKIP!")
			skip = false
			timer.stop()
			if di <= dialog.size() - 1: di += 1
			$TextScreen/AnimationPlayer.play("TypewriterEffect")
			if di < dialog.size(): screen.text = dialog[di]
			timer.start()
	else:
		action_menu.visible = true
		screen.text = ""


func create_char(character, char_name, money, sleep, motivation):
	character.character_name = char_name
	character.money = money # /1000
	character.sleep = sleep # /16
	character.motivation = motivation # /100


func _on_timer_timeout() -> void:
	di += 1
	if di <= dialog.size() - 1:
		$TextScreen/AnimationPlayer.play("TypewriterEffect")
		screen.text = dialog[di]
		timer.start()


func _on_destination_list_item_activated(index: int) -> void:
	$TextScreen/DestinationList.visible = false


func setup_action_menu():
	action_menu.tm = total_money
	action_menu.ts = total_sleep
	action_menu.tmot = total_motivation
	action_menu.char1 = char1
	action_menu.char2 = char2
	action_menu.gas = gasoline
	action_menu.format.append(char1.character_name)
	action_menu.format.append(char2.character_name)
	action_menu.format.append(char1.character_name)
	action_menu.format.append(char1.money)
	action_menu.format.append(char1.sleep)
	action_menu.format.append(char1.motivation)
	action_menu.format.append(char2.character_name)
	action_menu.format.append(char2.money)
	action_menu.format.append(char2.sleep)
	action_menu.format.append(char2.motivation)
	action_menu.format.append(gasoline)
	action_menu.format.append(gas_needed[0])
	action_menu.format.append(gas_needed[0] + gas_needed[1])
	action_menu.format.append(gas_needed[0] + gas_needed[1] + gas_needed[2])
	action_menu.format.append(gas_needed[0] + gas_needed[1] + gas_needed[2] + gas_needed[3])
	action_menu.format.append(char1.character_name)
	action_menu.format.append(' ')
	action_menu.format.append(char2.character_name)
	action_menu.format.append(' ')
