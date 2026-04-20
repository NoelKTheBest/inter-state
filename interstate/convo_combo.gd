extends Node

@onready var response: Label = $VBoxContainer/ResponseLabel
@onready var option_1: Button = $VBoxContainer/VBoxContainer/Option1
@onready var option_2: Button = $VBoxContainer/VBoxContainer/Option2
@onready var option_3: Button = $VBoxContainer/VBoxContainer/Option3
@onready var option_4: Button = $VBoxContainer/VBoxContainer/Option4
@onready var option_5: Button = $VBoxContainer/VBoxContainer/Option5

var Claudia
var Remy
var Angel

var last_positive_option_num
var current_person: Person

signal person_is_happy

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Claudia = Person.new()
	Claudia.dialog_options = [
		"Those boots look really nice, where did you get them?",
		"Would you like to help me drive across the country by sparing some change?",
		"Do you have any spare change?"
	]
	Claudia.good_option_num = 1
	Claudia.bad_option_num = 2
	Claudia.current_score = Claudia.init_score
	
	Remy = Person.new()
	Remy.dialog_options = [
		"How would you like me to drive across the country discovering exotic food for you?",
		"You want a ride across town?",
		"Would you give me money if I gave you food to feed your entire family?"
	]
	Remy.good_option_num = 2
	Remy.bad_option_num = 1
	Remy.current_score = Remy.init_score
	
	Angel = Person.new()
	Angel.dialog_options = [
		"How is your day going?",
		"I want to go see the bright lights of the big city, can you help me out?",
		"What do you do for work? I am a magician by trade",
		"Would you like me to drive you anywhere or help you run some errands?"
	]
	Angel.good_option_num = 1
	Angel.bad_option_num = 3
	Angel.current_score = Angel.init_score
	
	response.text = "Ready!"
	
	current_person = Claudia
	option_1.text = current_person.dialog_options[0]
	option_2.text = current_person.dialog_options[1]
	option_3.text = current_person.dialog_options[2]
	option_4.visible = false
	option_5.visible = false
	
	await person_is_happy
	
	response.text = "Ready!"
	last_positive_option_num = null
	
	current_person = Remy
	option_1.text = current_person.dialog_options[0]
	option_2.text = current_person.dialog_options[1]
	option_3.text = current_person.dialog_options[2]
	option_4.visible = false
	option_5.visible = false
	
	await person_is_happy
	
	response.text = "Ready!"
	last_positive_option_num = null
	
	current_person = Angel
	option_1.text = current_person.dialog_options[0]
	option_2.text = current_person.dialog_options[1]
	option_3.text = current_person.dialog_options[2]
	option_4.text = current_person.dialog_options[3]
	option_4.visible = true
	option_5.visible = false
	
	await person_is_happy
	
	response.text = "The End :)"


class Person:
	var dialog_options = []
	var good_option_num: int
	var bad_option_num: int
	var init_score: int = 1
	var current_score: int
	var bad_inc: int = -1
	var good_inc: int = 9223372036854775807
	#1000000000000000000
	#9223372036854775807


func check_numbers(button_number: int):
	# It is possible to soft lock and create a scenario 
	#	where the player has to press the good option then 
	#	the okay one and then the good one again.
	#	We should track whenever that happens
	
	var good_num = current_person.good_option_num
	var bad_num = current_person.bad_option_num
	
	if (button_number - 1) == good_num:
		if 1 + current_person.current_score > current_person.init_score:
			current_person.current_score += 1
			current_person.current_score = clampi(current_person.current_score, 0, 2)
			response.text = "good" + " " + str(current_person.current_score) 
			person_is_happy.emit()
		else:
			if last_positive_option_num != button_number - 1:
				current_person.current_score += 0
				current_person.current_score = clampi(current_person.current_score, 0, 2)
				response.text = "okay" + " " + str(current_person.current_score) 
				last_positive_option_num = button_number - 1
			else:
				current_person.current_score += 0
				current_person.current_score = clampi(current_person.current_score, 0, 2)
				response.text = "and?" + " " + str(current_person.current_score) 
				
	elif (button_number - 1) == bad_num:
		current_person.current_score -= 1
		current_person.current_score = clampi(current_person.current_score, 0, 2)
		response.text = "bad" + " " + str(current_person.current_score) 
	else:
		if last_positive_option_num != button_number - 1:
			current_person.current_score += 1
			current_person.current_score = clampi(current_person.current_score, 0, 2)
			response.text = "okay" + " " + str(current_person.current_score) 
			last_positive_option_num = button_number - 1
		else:
			current_person.current_score += 0
			current_person.current_score = clampi(current_person.current_score, 0, 2)
			response.text = "and?" + " " + str(current_person.current_score) 


func _on_option_1_pressed() -> void:
	check_numbers(1)


func _on_option_2_pressed() -> void:
	check_numbers(2)


func _on_option_3_pressed() -> void:
	check_numbers(3)


func _on_option_4_pressed() -> void:
	check_numbers(4)


func _on_option_5_pressed() -> void:
	check_numbers(5)
