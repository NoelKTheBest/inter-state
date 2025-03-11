extends Node2D


enum battle_state {STATE_BATTLESTART, STATE_PLAYERTURN, STATE_ENEMYTURN, STATE_BATTLEEND}


var current_state: int = 0
var rng = RandomNumberGenerator.new()
var player_is_dead: bool = false
var textbox: Node
var itemlist: Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	textbox = $TextEdit
	itemlist = $TextEdit/ItemList
	itemlist.position = textbox.size / 2 - (itemlist.size / 2)
	
	if current_state == battle_state.STATE_BATTLESTART:
		textbox.text = "Let's get ready to rumble!!!"
		print("player's turn")
		current_state = battle_state.STATE_PLAYERTURN


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") and current_state != battle_state.STATE_BATTLEEND:
		var ran = rng.randi_range(0, 3)
		if current_state == battle_state.STATE_PLAYERTURN:
			if ran == 0 and not player_is_dead:
				print("enemy died; battle end")
				current_state = battle_state.STATE_BATTLEEND
				return
			print("enemy's turn")
			current_state = battle_state.STATE_ENEMYTURN
		elif current_state == battle_state.STATE_ENEMYTURN:
			if ran == 0:
				print("player died")
				player_is_dead = true
				current_state = battle_state.STATE_PLAYERTURN
				return
			print("player's turn")
			current_state = battle_state.STATE_PLAYERTURN
	
	if player_is_dead and current_state == battle_state.STATE_PLAYERTURN:
		print("battle end")
		current_state = battle_state.STATE_BATTLEEND
		return
	
	if current_state == battle_state.STATE_BATTLEEND:
		get_tree().quit()
	


func _on_item_list_item_selected(index: int, extra_arg_0: bool, extra_arg_1: bool) -> void:
	print(index)
	print("Arg1" + str(extra_arg_0))
	print("Arg2" + str(extra_arg_1))


func _on_item_list_item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
	print(index)
	print(at_position)
	print(mouse_button_index)
	itemlist.deselect_all()
