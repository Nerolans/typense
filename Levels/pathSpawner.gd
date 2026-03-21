extends Path2D

var timer = 0
@export var spawnTime = 5

var follower:PackedScene = preload("res://Levels/enemyFollow.tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer = timer + delta
	
	if(timer > spawnTime):
		var newFollower = follower.instantiate()
		add_child(newFollower)
		timer = 0
		

func _input(event):
	if event.is_pressed():
		print("Une touche a été enfoncée : ", event.as_text())
		var oldest = get_child(0)
		print(oldest.loseLive())
		
