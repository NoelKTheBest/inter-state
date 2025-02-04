extends Node


func _on_timer_timeout() -> void:
	$Label.visible = false
	$Label2.visible = true
	$Timer2.start(1.5)


func _on_timer_2_timeout() -> void:
	$Label2.visible = false
	$Label3.visible = true
	$Timer3.start(1.5)


func _on_timer_3_timeout() -> void:
	$Label3.visible = false
