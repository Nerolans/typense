extends CanvasLayer

func _ready():
	$Button.pressed.connect(_on_level1)
	$Button2.pressed.connect(_on_level2)

func _on_level1():
	get_tree().change_scene_to_file("res://Levels/LevelTest.tscn")

func _on_level2():
	get_tree().change_scene_to_file("res://Levels/level2.tscn")
