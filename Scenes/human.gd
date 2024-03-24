extends CharacterBody2D

@export var animator: AnimatedSprite2D

var MAX_VELOCITY: int = 50
var MAX_SPEED: int = 25

var blood: int
var speed: int = 30

func _ready():
	blood = randi_range(1, 4)
	MAX_VELOCITY *= blood
	MAX_SPEED *= blood
	speed *= blood
	animator.animation = "human" + str(blood)
	animator.play()


func _physics_process(delta):
	
	if Globals.is_running:
		velocity.x += delta * speed
		velocity.x = min(velocity.x, MAX_VELOCITY)
		speed += delta * 10
		speed = min(speed, MAX_SPEED)
			
	move_and_slide()
