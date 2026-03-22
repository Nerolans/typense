extends Path2D

var timer = 0
@export var spawnTime = 2.5
var kills = 0
var boss = false
var tmpTime = 0

var follower:PackedScene = preload("res://Levels/enemyFollow2.tscn")
func _process(delta):
	timer = timer + delta

	if(timer > spawnTime):
		var newFollower = follower.instantiate()
		newFollower.runSpeed = 100 + (kills * (randi() % 2+1))
		var newSpawnTime = spawnTime - (kills * (randi() % 10)*0.001)
		if newSpawnTime < 0.25:
			newSpawnTime = 0.25
		spawnTime = newSpawnTime
		print(spawnTime)
		print(kills)
		print(newFollower.runSpeed)
		add_child(newFollower)
		timer = 0
	
	if kills == 40 && boss == false:
		tmpTime = spawnTime
		boss = true
		spawnTime = 30
		var boss:PackedScene = preload("res://Levels/Assets/bossFollow.tscn")
		var newBoss = boss.instantiate()
		add_child(newBoss)
		newBoss.runSpeed = 230
		
	if kills == 50 && boss == false:
		tmpTime = spawnTime
		boss = true
		spawnTime = 30
		var boss:PackedScene = preload("res://Levels/Assets/bossFollow.tscn")
		var newBoss = boss.instantiate()
		add_child(newBoss)
		newBoss.runSpeed = 260
		
	if kills == 25 && boss == false:
		tmpTime = spawnTime
		boss = true
		spawnTime = 30
		var boss:PackedScene = preload("res://Levels/Assets/bossFollow.tscn")
		var newBoss = boss.instantiate()
		add_child(newBoss)
		newBoss.runSpeed = 130
		
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
				
func loseLive():
	get_parent().loseLive()
