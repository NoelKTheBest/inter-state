extends Node2D


enum battle_state {STATE_BATTLESTART, STATE_PLAYERTURN, STATE_ENEMYTURN, STATE_BATTLEEND}


var current_state: int = 0
var action: String = ""
var rng = RandomNumberGenerator.new()
var player_is_dead: bool = false

@onready var textbox: Node = $TextEdit
@onready var itemlist: Node = $ItemList
@onready var player: Node = $Player
@onready var npc: Node = $NPC
@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#itemlist.position = textbox.size / 2 - (itemlist.size / 2)
	
	if current_state == battle_state.STATE_BATTLESTART:
		textbox.text = "Can I have some money?"
		timer.start(0.5)
		itemlist.visible = false


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
	print("hello")
	print(index)
	print("Arg1" + str(extra_arg_0))
	print("Arg2" + str(extra_arg_1))


func _on_item_list_item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
	if mouse_button_index == 1:
		match index:
			0:
				action = "PLEAD"
			1:
				action = "INSIST"
			2:
				action = "COMPLAIN"
			3:
				action = "TALK"
		itemlist.deselect_all()
		itemlist.visible = false
		textbox.text = "Player used " + str(action) + "!"
		timer.start(1)


func _on_timer_timeout() -> void:
	if current_state == battle_state.STATE_BATTLESTART:
		current_state = battle_state.STATE_PLAYERTURN
		itemlist.visible = true
	elif current_state == battle_state.STATE_PLAYERTURN:
		current_state = battle_state.STATE_ENEMYTURN
		npc.receive_action(action)
	elif current_state == battle_state.STATE_ENEMYTURN:
		current_state = battle_state.STATE_PLAYERTURN
		itemlist.visible = true


func _on_npc_respond(response: String) -> void:
	timer.start(1)
	print(response)
	textbox.text = response
