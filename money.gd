extends Node

signal menu_opened(source)

var gold: int = 5000
signal gold_changed(new_amount)

func add_gold(amount) -> int:
	gold += amount
	emit_signal("gold_changed", gold)
	return gold

func spend_gold(amount) -> bool:
	if amount <= gold:
		gold = gold - amount
		emit_signal("gold_changed", gold)
		return true
	else:
		print("You don't have the founds")
		return false
