extends CharacterBody2D

signal start_convo(x_pos)

const SPEED = 300.0
@export var area2d: Node
@onready var animator = $AnimatedSprite2D
var can_talk_to_npc: bool = false

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") and can_talk_to_npc:
		start_convo.emit(position.x)
		if area2d.position.x <= position.x:
			$AnimatedSprite2D.flip_h = true
		elif area2d.position.x > position.x:
			$AnimatedSprite2D.flip_h = false
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		animator.flip_h = true if direction == -1 else false
		animator.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animator.play("idle")

	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		can_talk_to_npc = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		can_talk_to_npc = false
