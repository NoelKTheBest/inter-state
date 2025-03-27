extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_character_body_2d_start_convo(x_pos: Variant) -> void:
	if x_pos <= position.x:
		$AnimatedSprite2D.flip_h = true
	elif x_pos > position.x:
		$AnimatedSprite2D.flip_h = false
