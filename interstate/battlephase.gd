extends Node2D


enum battle_state {STATE_BATTLESTART, STATE_PLAYERTURN, STATE_ENEMYTURN, STATE_BATTLEEND}

var current_state: int = 0
var rng = RandomNumberGenerator.new()
var player_is_dead: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Access values with Name.KEY, prints '5'
	print(battle_state.STATE_BATTLESTART)
	# Use dictionary methods:
	# prints '["STATE_IDLE", "STATE_JUMP", "STATE_SHOOT"]'
	print(battle_state.keys())
	# prints '{ "STATE_IDLE": 0, "STATE_JUMP": 5, "STATE_SHOOT": 6 }'
	print(battle_state)
	# prints '[0, 5, 6]'
	print(battle_state.values())
	
	if current_state == battle_state.STATE_BATTLESTART:
		print("Let's get ready to rumble!!!")
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
	
