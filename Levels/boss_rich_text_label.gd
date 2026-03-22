extends RichTextLabel


var lives = 0

func _ready() -> void:
	print("test")
	var length = 20
	text = ""
	const chars ="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	for i in range(length):
		if i % 2 == 0:
			text += str(randi() % 10)
		else:
			text += chars[randi() % chars.length()]
		
	lives = text.length()-1





func _process(delta: float) -> void:
	pass
