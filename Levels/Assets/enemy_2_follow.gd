extends PathFollow2D

@export var runSpeed = 40

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



func _process(delta):

	progress = (progress + runSpeed * delta)
	var progressConc = snapped(progress,1)

	if progressConc >= 0 && progressConc <= 5:
		$Enemy.stop()
		$Enemy.play("right")
	elif progressConc >= 198 && progressConc <= 205:
		$Enemy.stop()
		$Enemy.play("down")
	elif progressConc >= 323 && progressConc <= 330:
		$Enemy.stop()
		$Enemy.play("right")
	elif progressConc >= 576 && progressConc <= 580:
		$Enemy.stop()
		$Enemy.play("up")
	elif progressConc >= 645 && progressConc <= 650:
		$Enemy.stop()
		$Enemy.play("right")
	elif progressConc >= 837 && progressConc <= 845:
		$Enemy.stop()
		$Enemy.play("down")
	elif progressConc >= 1025 && progressConc <= 1030:
		$Enemy.stop()
		$Enemy.play("right")
	elif progressConc >= 1085 && progressConc <= 1090:
		$Enemy.stop()
		$Enemy.play("down")
	elif progressConc >= 1285 && progressConc <= 1290:
		$Enemy.stop()
		$Enemy.play("left")
	elif progressConc >= 1467 && progressConc <= 1475:
		$Enemy.stop()
		$Enemy.play("up")
	elif progressConc >= 1530 && progressConc <= 1535:
		$Enemy.stop()
		$Enemy.play("left")
	elif progressConc >= 1715 && progressConc <= 1720:
		$Enemy.stop()
		$Enemy.play("up")
		
	if progress_ratio == 1:
		get_parent().kills+=1
		get_parent().loseLive()
		Money.add_gold(8)
		queue_free()
