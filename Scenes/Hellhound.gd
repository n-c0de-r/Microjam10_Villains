extends CharacterBody2D

@export var animator: AnimatedSprite2D

signal healthChanged(amount: int)

const START_SPEED: float = 30.0

const MAX_BLOOD: int = 100
const MAX_SPEED: int = 100
const MAX_VELOCITY: int = 200

var _speed: float
var _blood: int = 100
var _distance: int = 0


func _ready():
	_blood = MAX_BLOOD
	_speed = START_SPEED


func _physics_process(delta):
	velocity.y += Globals.GRAVITY * delta
	
	if Globals.is_running:
		velocity.x += delta * _speed
		velocity.x = min(velocity.x, MAX_VELOCITY)
		_speed += delta * 10
		_speed = min(_speed, MAX_SPEED)
		
		if is_on_floor():
			if(Input.is_action_just_pressed("jump")):
				velocity.y = Globals.JUMP_SPEED
				animator.play("jump")
			else:
				animator.play("run")
		
		if _blood <= 0:
			Globals.is_running = false
			animator.play("die")
		elif (int(position.x) % Globals._screen_size.x) < 5:
			update_health(-1)
			
	move_and_slide()
	
	_distance = int(position.x / 10)


func update_health(amount: int) -> void:
	_blood += amount
	_blood = min(_blood, MAX_BLOOD)
	healthChanged.emit(amount)


func slowdown(amount: int):
	_speed = amount
	velocity.x -= amount


func _on_keeper_animation_finished():
	animator.play("alert")


func _on_animator_animation_finished():
	if animator.animation == "die":
		get_tree().reload_current_scene()
		
	if (animator.animation == "alert") and (not Globals.is_running):
		Globals.is_running = true
