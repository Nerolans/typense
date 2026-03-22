extends CanvasLayer

func _ready():
	$Button.pressed.connect(_on_btn_rejouer)
	$Button2.pressed.connect(_on_btn_menu)

func _on_btn_rejouer():
	Money.gold = 500
	get_tree().reload_current_scene()

func _on_btn_menu():
	Money.gold = 500
	get_tree().change_scene_to_file("res://menu_canvas_layer.tscn")
