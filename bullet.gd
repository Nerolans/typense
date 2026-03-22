extends Area2D

const RIGHT = Vector2.RIGHT
var SPEED: int = 500
var bullet_type = ""



func _process(delta):
	var movement = RIGHT.rotated(rotation) * SPEED * delta
	global_position += movement

func destroy():
	queue_free()
	

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_area_entered(area):
	if bullet_type == "Antiletter":
		area.get_parent().loseLive()
		destroy()
	if bullet_type == "Slower":
		area.get_parent().set_runspeed(2) 
		
func set_bulletType(newtype:String):
	bullet_type = newtype
	var sprite = get_node("AnimatedSprite2D")
	if bullet_type == "Antiletter":
		sprite.play("antiletterbullet")
	if bullet_type == "Slower":
		sprite.play("slowerbullet")
	
