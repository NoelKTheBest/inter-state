extends Node

var total_money
var total_sleep
var total_motivation
var gasoline

var no_money: bool = false
var is_everyone_tired: bool = false
var no_motivation: bool = false
var on_E: bool = false

var game_over_scenarios = ['BROKE', 'TIRED', 'BORED', 'E', 'CRASH']

var screen: Node
var timer: Node
var quickselect: Node
var progress_mode

var character_scene: PackedScene = preload("res://character.tscn")
var char1
var char2

var char_toggle = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	char1 = character_scene.instantiate()
	char2 = character_scene.instantiate()
	create_char(char1, "Sheen", 100, 10, 87)
	create_char(char2, "Shareen", 100, 14, 66)
	
	total_money = char1.money + char2.money
	total_sleep = char1.sleep + char2.sleep
	total_motivation = char1.motivation + char2.motivation
	
	screen = $GameScreen
	timer = $GameScreen/Timer
	quickselect = $GameScreen/QuickSelect
	screen.text = "hello world. Welcome to Interstate.\nThe game where you simulate the experience of being on a roadtrip."
	
	progress_mode = "destination"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress(progress_mode)
	
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
	
	match progress_mode:
		"menu":
			quickselect.visible = true
			quickselect.text = name1 + '\n' + name2
	
	if no_money:
		game_over(game_over_scenarios[0])
	
	if is_everyone_tired:
		#game_over(game_over_scenarios[1])
		pass
		# roll for game over scenario 'CRASH'
		# if CRASH then game over, else characters forcefully sleep
	
	if no_motivation:
		game_over(game_over_scenarios[2])
	
	if on_E:
		game_over(game_over_scenarios[3])
	


func progress(action):
	match action:
		"destination":
			if timer.is_stopped(): timer.start(2)
		"rss":
			var a = "We need money, gas, and motivation.\n"
			var b = "We have %d dollars, %d sleep and %d motivation.\n"
			var c = "We need %d gallons for gas to get to the next stop."
			var actual_string = (a + b + c) % [total_money, total_sleep, total_motivation, 5]
			screen.text = actual_string
			if timer.is_stopped(): timer.start(1.5)


func create_char(character, char_name, money, sleep, motivation):
	character.character_name = char_name
	character.money = money # /1000
	character.sleep = sleep # /16
	character.motivation = motivation # /100


func game_over(scenario: String):
	print(scenario)


func _on_timer_timeout() -> void:
	match progress_mode:
		"destination":
			screen.text = "Where do you want to go?"
			$GameScreen/DestinationList.visible = true
			progress_mode = 1
		"rss":
			screen.text = screen.text + "\nWhat will each character do?"
			progress_mode = "menu"


func _on_destination_list_item_activated(index: int) -> void:
	progress_mode = "rss"
	$GameScreen/DestinationList.visible = false
