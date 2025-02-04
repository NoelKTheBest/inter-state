extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_up"):
		print("↑")
		# decrement index
	elif Input.is_action_pressed("ui_down"):
		print("↓")
		# increment index
