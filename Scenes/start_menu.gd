extends Control

signal started


func _on_start_pressed():
	started.emit()
	hide()


func _on_quit_pressed():
	get_tree().quit()
