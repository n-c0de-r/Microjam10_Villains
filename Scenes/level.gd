extends Node2D

@export var _human: PackedScene
@export var _player: CharacterBody2D
@export var _ground: TileMap
@export var _ui: ParallaxBackground
@export var _prey_container: Node2D

var _screen_count: int
var _cooldown: int
var _tile_count: int = 0
const CELL_NUMBER: int = 16
const CELL_LOCATION: Vector2i = Vector2i(1,0)


func _ready():
	Globals._screen_size = get_viewport_rect().size


func _physics_process(delta):
	if Globals.is_running:
		_ui.update_score(_player._distance)
		
		if (_player._distance % CELL_NUMBER) < 5:
			_tile_count += 2
			_ground.set_cell(0, Vector2i(CELL_NUMBER+_tile_count,6), 0, CELL_LOCATION)
			# TODO: Remove unused cells to save memory
		
		if (int(_player.position.x) % Globals._screen_size.x) < 5:
			_screen_count += 1
			_cooldown -= 1
		
		if _screen_count >= 5 and _cooldown <= 0:
			_spawn_prey(_human)


func _spawn_prey(prey: PackedScene):
	if _prey_container.get_child_count() < 3:
		var inst: CharacterBody2D = prey.instantiate()
		inst.position = Vector2i(_player.position.x + Globals._screen_size.x, 210)
		_prey_container.add_child(inst)
		_cooldown = randi_range(2, 5)

func _on_hellhound_health_changed(amount):
	_ui.update_health(amount)
