extends RichTextLabel


var lives = 0

func _ready() -> void:
	var file = FileAccess.open("res://list.txt", FileAccess.READ)
	var content = file.get_as_text()
	var word = content.split('\n')
	var rdmNumber = randi() % 500
	text = word[rdmNumber]
	lives = text.length()-1





func _process(delta: float) -> void:
	pass
