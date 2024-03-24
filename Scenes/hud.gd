extends ParallaxBackground

func _ready():
	$HealthBar.value = Globals.MAX_BLOOD


func update_health(amount: int) -> void:
	$HealthBar.value += amount


func _on_start_menu_started():
	$HealthBar.show()
