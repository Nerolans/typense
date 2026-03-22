extends Node2D

@export var game_over_scene: PackedScene

func _ready():
	$Core.game_over.connect(_on_game_over)

func _on_game_over():
	var screen = game_over_scene.instantiate()
	add_child(screen)

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			for enfant in get_children():
				if enfant.has_method("_close_menu"):
					enfant._close_menu()

func loseLive():
	$Core.lives -= 1
