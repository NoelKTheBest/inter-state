extends AnimatedSprite2D

@export var money: int = 1
@export var sleep: int = 1
@export var motivation: int = 1
@export var character_name: String = ""

signal out_of_money
signal too_tired
signal bored_af

var test = "ABC"

func _ready() -> void:
	pass


# this function will continuously monitor the state of the character
# one certain conditions are met, i will emit signals to the main game script
# 	to do certain things
func _process(delta: float) -> void:
	if money <= 0:
		print("I'm outta money")
		out_of_money.emit()
	
	if sleep <= 0:
		print("zzzzzzzz")
		too_tired.emit()
	
	if motivation <= 0:
		print("I'm going home")
		bored_af.emit()
