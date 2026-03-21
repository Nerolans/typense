extends Area2D

const RIGHT = Vector2.RIGHT
var SPEED: int = 500

@onready var sprite = $AnimatedSprite2D

func _ready():
	sprite.play("default")

func _process(delta):
	var movement = RIGHT.rotated(rotation) * SPEED * delta
	global_position += movement

func destroy():
	queue_free()
	

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_area_entered(area):
	area.get_parent().loseLive()
	destroy()
	
