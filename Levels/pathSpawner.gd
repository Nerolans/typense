extends Path2D

var timer = 0
@export var spawnTime = 1
var kills = 0
var boss = false

var follower:PackedScene = preload("res://Levels/enemyFollow.tscn")
func _process(delta):
	timer = timer + delta

	if(timer > spawnTime):
		var newFollower = follower.instantiate()
		newFollower.runSpeed = 100 + (kills*randi() % 6)
		var newSpawnTime = spawnTime - kills * (randi() % 10)*0.001
		if newSpawnTime < 0.30:
			newSpawnTime = 0.30
		spawnTime = newSpawnTime
		add_child(newFollower)
		timer = 0
	
	if kills == 1 && boss == false:
		boss = true
		spawnTime = 30
		var newBoss = boss.instantiate()
		add_child(newBoss)
		newBoss.runSpeed = 200
		
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
