extends CharacterBody2D

@export var animator: AnimatedSprite2D

var MAX_VELOCITY: int = 40
var MAX_SPEED: int = 30

var _blood: int
var _base: int
var speed: int = 20

func _ready():
	_base = randi_range(1, 4)
	_blood = _base + randi_range(1, 4)
	MAX_VELOCITY *= _base
	MAX_SPEED *= _base
	speed *= _base
	animator.animation = "human" + str(_base)
	animator.play()


func _physics_process(delta):
	
	if Globals.is_running:
		velocity.x += delta * speed
		velocity.x = min(velocity.x, MAX_VELOCITY)
		speed += delta * 10
		speed = min(speed, MAX_SPEED)
			
	move_and_slide()


func _on_area_2d_body_entered(body):
	if body.name == "Hellhound":
		body.update_health(_blood)
		body.slowdown(10 * _base)
		animator.play("splash" + str(randi_range(1,3)))
		


func _on_animator_animation_finished():
	queue_free()
