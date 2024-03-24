extends AnimatedSprite2D

func splash():
	play("splash" + str(randi_range(1, 3)))
