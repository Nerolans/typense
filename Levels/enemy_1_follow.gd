extends PathFollow2D

@export var runSpeed = 20

func _ready():
	$Enemy.stop()
	$Enemy.play("down")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	progress = (progress + runSpeed * delta)
	var progressConc = snapped(progress,1)
	if progressConc == 0:
		$Enemy.stop()
		$Enemy.play("down")
	elif progressConc == 134:
		$Enemy.stop()
		$Enemy.play("left")
	elif progressConc == 382:
		$Enemy.stop()
		$Enemy.play("down")
	elif progressConc == 509:
		$Enemy.stop()
		$Enemy.play("right")
	elif progressConc == 636:
		$Enemy.stop()
		$Enemy.play("down")
	elif progressConc == 836:
		$Enemy.stop()
		$Enemy.play("left")
	elif progressConc == 1029:
		$Enemy.stop()
		$Enemy.play("down")
	elif progressConc == 1152:
		$Enemy.stop()
		$Enemy.play("right")
	elif progressConc == 1541:
		$Enemy.stop()
		$Enemy.play("up")
	elif progressConc == 1666:
		$Enemy.stop()
		$Enemy.play("right")
	elif progressConc == 1796:
		$Enemy.stop()
		$Enemy.play("down")
	elif progressConc == 2118:
		$Enemy.stop()
		$Enemy.play("left")
	elif progressConc == 2248:
		$Enemy.stop()
		$Enemy.play("down")
	elif progressConc == 2375:
		$Enemy.stop()
		$Enemy.play("left")
	if progress_ratio == 1:
		queue_free()
	
