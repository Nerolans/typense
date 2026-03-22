extends PathFollow2D
var timer = 0
@export var runSpeed = 40
var oldspeed = 0
func _ready():
	$Enemy.stop()
	$Enemy.play("down")

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
		get_parent().kills+=1
		Money.add_gold(8)
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

	if progressConc >= 0 && progressConc <= 5:
		$Enemy.stop()
		$Enemy.play("right")
	elif progressConc >= 195 && progressConc <= 200:
		$Enemy.stop()
		$Enemy.play("down")
	elif progressConc >= 315 && progressConc <= 320:
		$Enemy.stop()
		$Enemy.play("right")
	elif progressConc >= 570 && progressConc <= 575:
		$Enemy.stop()
		$Enemy.play("up")
	elif progressConc >= 635 && progressConc <= 640:
		$Enemy.stop()
		$Enemy.play("right")
	elif progressConc >= 830 && progressConc <= 835:
		$Enemy.stop()
		$Enemy.play("down")
	elif progressConc >= 1020 && progressConc <= 1025:
		$Enemy.stop()
		$Enemy.play("right")
	elif progressConc >= 1080 && progressConc <= 1085:
		$Enemy.stop()
		$Enemy.play("down")
	elif progressConc >= 1275 && progressConc <= 1280:
		$Enemy.stop()
		$Enemy.play("left")
	elif progressConc >= 1465 && progressConc <= 1470:
		$Enemy.stop()
		$Enemy.play("up")
	elif progressConc >= 1525 && progressConc <= 1530:
		$Enemy.stop()
		$Enemy.play("left")
	elif progressConc >= 1720 && progressConc <= 1725:
		$Enemy.stop()
		$Enemy.play("up")
	
	if progress_ratio == 1:
		get_parent().kills+=1
		get_parent().loseLive()
		Money.add_gold(8)
		queue_free()
