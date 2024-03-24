extends CharacterBody2D

@export var animator: AnimatedSprite2D

signal healthChanged(amount: int)

const START_SPEED: float = 30.0

const MAX_SPEED: int = 100
const MAX_VELOCITY: int = 200

var blood: int = 100
var speed: float


func _init():
	blood = Globals.MAX_BLOOD
	speed = START_SPEED


func _physics_process(delta):
	velocity.y += Globals.GRAVITY * delta
	
	if Globals.is_running:
		velocity.x += delta * speed
		velocity.x = min(velocity.x, MAX_VELOCITY)
		speed += delta * 10
		speed = min(speed, MAX_SPEED)
		
		if is_on_floor():
			if(Input.is_action_just_pressed("jump")):
				velocity.y = Globals.JUMP_SPEED
				animator.play("jump")
			else:
				animator.play("run")
		
		if blood <= 0:
			Globals.is_running = false
			animator.play("die")
			
	move_and_slide()


func update_health(amount: int) -> void:
	blood += amount


func _on_keeper_animation_finished():
	animator.play("alert")


func _on_animator_animation_finished():
	if animator.animation == "die":
		get_tree().reload_current_scene()
		
	if (animator.animation == "alert") and (not Globals.is_running):
		Globals.is_running = true
