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
var destination_list: Node

var character_scene: PackedScene = preload("res://character.tscn")
var char1
var char2

var dialog = []
var format = []
var di: int = 0

var skip: bool = false
var long_timer_active: bool = false
var timeleft: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Get References
	$TextScreen/AnimationPlayer.play("TypewriterEffect")
	screen = $TextScreen/Label
	timer = $TextScreen/Timer
	destination_list = $TextScreen/DestinationList
	
	# Load Dialog
	var file = FileAccess.open("res://Dialog/Game_Start.txt", FileAccess.READ)
	while file.eof_reached() != true:
		dialog.append(file.get_line())
	file = FileAccess.open("res://Dialog/DialogMenus/characteractionmenu.txt", FileAccess.READ)
	dialog[6] = file.get_as_text()
	
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
	
	setup_destination_list()
	
	dialog[3] = dialog[3] % [total_money, total_sleep, total_motivation]
	dialog[4] = dialog[4] % [5]
	dialog[6] = dialog[6] % format
	#dialog[dialog.size() - 1] = "...."


func _process(delta: float) -> void:
	if di <= dialog.size() - 1:
		if long_timer_active: 
			timeleft = roundi(timer.time_left)
			$TextScreen/TimeLeftLabel.text = str(timeleft)
		
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
			print(di)
			if di < 6: timer.start()
			else: 
				timer.start(15)
				long_timer_active = true
	else:
		_on_destination_list_transition()
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
		if di < 6: timer.start()
		else: 
			timer.start(15)
			long_timer_active = true


func setup_destination_list():
	#destination_list.tm = total_money
	#destination_list.ts = total_sleep
	#destination_list.tmot = total_motivation
	#destination_list.char1 = char1
	#destination_list.char2 = char2
	#destination_list.gas = gasoline
	format.append(char1.character_name)
	format.append(char2.character_name)
	format.append(char1.character_name)
	format.append(char1.money)
	format.append(char1.sleep)
	format.append(char1.motivation)
	format.append(char2.character_name)
	format.append(char2.money)
	format.append(char2.sleep)
	format.append(char2.motivation)
	format.append(gasoline)
	format.append(gas_needed[0])
	format.append(gas_needed[0] + gas_needed[1])
	format.append(gas_needed[0] + gas_needed[1] + gas_needed[2])
	format.append(gas_needed[0] + gas_needed[1] + gas_needed[2] + gas_needed[3])


func _on_destination_list_transition() -> void:
	# Remove the current level
	var root = get_tree().root
	var level = root.get_node("Node")
	root.remove_child(level)
	level.call_deferred("free")
	
	# Add the next level
	var next_level_resource = load("res://transition1.tscn")
	var next_level = next_level_resource.instantiate()
	root.add_child(next_level)
