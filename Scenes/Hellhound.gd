extends CharacterBody2D

#const START_SPEED: float = 10.0
const MAX_BLOOD: int = 100
#const MAX_SPEED: int = 100
const MAX_VELOCITY: int = 200

var blood: int = 100
var speed: float

func _init():
	blood = MAX_BLOOD
	#speed = START_SPEED

func _physics_process(delta):
	velocity.y += Globals.GRAVITY * delta
	velocity.x += delta * 50
	print(velocity.x)
	velocity.x = min(velocity.x, MAX_VELOCITY)
	
	if Globals.is_running:
		if is_on_floor():
			if(Input.is_action_just_pressed("jump")):
				velocity.y = Globals.JUMP_SPEED
				$Animator.play("jump")
			else:
				$Animator.play("run")
	move_and_slide()
