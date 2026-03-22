extends Node2D

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			for enfant in get_children():
				if enfant.has_method("_close_menu"):
					enfant._close_menu()
					
func loseLive():
	$Core.lives -=1
