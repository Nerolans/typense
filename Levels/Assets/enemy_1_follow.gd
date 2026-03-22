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

	if progressConc == 0:
		$Enemy.stop()
		$Enemy.play("down")
	elif progressConc >= 130 && progressConc <= 140  :
		$Enemy.stop()
		$Enemy.play("left")
	elif progressConc >= 382 && progressConc <= 392:
		$Enemy.stop()
		$Enemy.play("down")
	elif progressConc >= 509 && progressConc <= 520  :
		$Enemy.stop()
		$Enemy.play("right")
	elif progressConc >= 636 && progressConc <= 646:
		$Enemy.stop()
		$Enemy.play("down")
	elif progressConc >= 836 && progressConc <= 846:
		$Enemy.stop()
		$Enemy.play("left")
	elif progressConc >= 1029 && progressConc <= 1039:
		$Enemy.stop()
		$Enemy.play("down")
	elif progressConc >= 1145 && progressConc <= 1152:
		$Enemy.stop()
		$Enemy.play("right")
	elif progressConc >= 1535 && progressConc <= 1542:
		$Enemy.stop()
		$Enemy.play("up")
	elif progressConc >= 1662 && progressConc <= 1670:
		$Enemy.stop()
		$Enemy.play("right")
	elif progressConc >= 1792 && progressConc <= 1800:
		$Enemy.stop()
		$Enemy.play("down")
	elif progressConc >= 2115 && progressConc <= 2120:
		$Enemy.stop()
		$Enemy.play("left")
	elif progressConc >= 2245 && progressConc <= 2251:
		$Enemy.stop()
		$Enemy.play("down")
	elif progressConc >= 2372 && progressConc <= 2378:
		$Enemy.stop()
		$Enemy.play("left")
	if progress_ratio == 1:
		get_parent().kills+=1
		get_parent().loseLive()
		Money.add_gold(8)
		queue_free()
