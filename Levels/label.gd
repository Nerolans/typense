extends Label

var lives = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var file = FileAccess.open("res://list.txt", FileAccess.READ)
	var content = file.get_as_text()
	var word = content.split('\n')
	var rdmNumber = randi() % 500
	text = word[rdmNumber]
	lives = text.length()-1
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
