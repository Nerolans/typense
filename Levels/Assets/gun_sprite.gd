extends AnimatedSprite2D
var level = 1
@onready var gunSprite = $GunSprite

func level_up():
	if level == 1:
		gunSprite.play("level1")
	elif level == 2:
		gunSprite.play("level2")
	elif level == 3: 
		gunSprite.play("level3")
