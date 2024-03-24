extends AnimatedSprite2D

func _on_start_menu_started():
	play("start")


func _on_animation_finished():
	play("Idle")
