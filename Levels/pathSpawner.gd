extends Path2D

var timer = 0
@export var spawnTime = 5

var follower:PackedScene = preload("res://Levels/enemyFollow.tscn")
func _process(delta):
	timer = timer + delta

	if(timer > spawnTime):
		var newFollower = follower.instantiate()
		newFollower.runSpeed = 100
		add_child(newFollower)
		timer = 0

func sort_childrens(a, b):
	return a.progress > b.progress

func _input(event):
	if event.is_pressed():
		if get_child_count() != 0:
			var childs = get_children()
			childs.sort_custom(sort_childrens)
			var oldest = childs[0]
			if event.as_text() == oldest.getlastChr():
				oldest.loseLive()
