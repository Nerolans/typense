extends AnimatedSprite2D
signal game_over
var lives = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func loseLive():
	lives -= 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if lives == 4:
		play("4")
	elif lives == 3:
		play("3")
	elif lives == 2:
		play("2")
	elif lives == 1:
		play("1")
	elif lives == 0:
		play("0")
		game_over.emit()
