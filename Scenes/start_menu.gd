extends Control

signal started

func _on_start_pressed():
	started.emit()
	hide()

func _on_quit_pressed():
	pass # Replace with function body.
