extends ParallaxBackground

@export var _ui: Control
@export var _healthBar: TextureProgressBar
@export var _score: Label

func _ready():
	_healthBar.value = _healthBar.max_value


func update_health(amount: int) -> void:
	_healthBar.value += amount


func update_score(amount: int) -> void:
	_score.text = str(amount)


func _on_start_menu_started():
	_ui.show()
