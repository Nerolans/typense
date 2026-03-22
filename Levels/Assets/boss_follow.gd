extends PathFollow2D

@export var runSpeed = 40
var oldspeed = 0
var timer = 0
func _ready():
	$Boss.stop()
	$Boss.play("default")
	progress = 0

func loseLive():
	var label = get_child(2)
	label.lives -= 1
	var oldWord = label.text
	var newWord = ""

	for i in range(oldWord.length(), 0, -1):
		if i > label.lives + 1:
			newWord += "[color=white]"+oldWord[oldWord.length()-i]+"[/color]"
		else:
			newWord += "[color=black]"+oldWord[oldWord.length()-i]+"[/color]"

	label.parse_bbcode(newWord)

	if label.lives < 0:
		get_parent().kills +=1
		get_parent().spawnTime = get_parent().tmpTime + 1
		get_parent().boss = false
		Money.add_gold(50)
		queue_free()

func getlastChr()->String:
	var label = get_child(2)
	var chr = label.text[label.text.length()-label.lives-1]
	return chr

var slowed = false
func set_runspeed(debuff:int):
	if slowed == false:
		oldspeed = runSpeed
		runSpeed = runSpeed/debuff
		slowed = true
	timer = 0


func _process(delta):
	if slowed ==true:
		timer += delta
		if timer > 5:
			print(timer)
			runSpeed = oldspeed
			timer = 0  
	progress = (progress + runSpeed * delta)
	var progressConc = snapped(progress,1)
	
	if progress_ratio == 1:
		get_parent().kills +=1
		get_parent().spawnTime = get_parent().tmpTime + 1
		get_parent().boss = false
		get_parent().loseLive()
		Money.add_gold(50)
		queue_free()
