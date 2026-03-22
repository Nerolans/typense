extends Area2D
signal background_clicked()
enum TowerType { NONE, SLOWER, ANTILETTER }
var current_tower: TowerType = TowerType.NONE
var current_level: int = 0
var turret_node = null
const COSTS = {
	"Slower": [100, 150, 200],
	"antiletter": [120, 180, 250]
}
const SELL_RATIO = 0.5

@onready var menu = $"CanvasLayer/PanelContainer"
@onready var label = $"CanvasLayer/PanelContainer/VBoxContainer/Label"
@onready var btn_tower1 = $"CanvasLayer/PanelContainer/VBoxContainer/HBoxContainer/BtnTower1"
@onready var btn_tower2 = $"CanvasLayer/PanelContainer/VBoxContainer/HBoxContainer/BtnTower2"
@onready var btn_sell = $"CanvasLayer/PanelContainer/VBoxContainer/HBoxContainer/BtnSell"
@onready var gold_label = $"/root/LevelTest/GoldLabel"
@onready var animatedLabel = $"/root/LevelTest/GoldAnimated"
@export var TURRET_SLOWER: PackedScene = preload("res://Levels/turret.tscn")
@export var TURRET_ANTILETTER: PackedScene = preload("res://Levels/turret.tscn")
@onready var spawn_points = [$TurretSpawn1]    



func _ready():
	input_pickable = true
	input_event.connect(_on_input_event)
	menu.visible = false
	btn_tower1.pressed.connect(_on_btn_tower1)
	btn_tower2.pressed.connect(_on_btn_tower2)
	btn_sell.pressed.connect(_on_btn_sell)
	gold_label.text = " : %d" % Money.gold
	Money.gold_changed.connect(_on_gold_changed)
	Money.menu_opened.connect(_on_any_menu_opened)
	
func _on_gold_changed(new_amount):
	gold_label.text = " : %d" % new_amount

func _on_any_menu_opened(source):
	if source != self :
		_close_menu()

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			_open_menu()

func _open_menu():
	Money.menu_opened.emit(self)
	animatedLabel.position.x = 850
	animatedLabel.position.y = 943
	gold_label.position.y = 920
	gold_label.position.x = 870
	menu.visible = true
	_update_menu()

func _close_menu():
	animatedLabel.position.x = 850
	animatedLabel.position.y = 988
	gold_label.position.y = 965.0
	gold_label.position.x = 870
	menu.visible = false

func _update_menu():
	match current_tower:
		TowerType.NONE:
			label.text = "Choose a Turret"
			btn_tower1.text = "Slower lvl1"
			btn_tower2.text = "Anti Letter lvl1"
			btn_tower1.visible = true
			btn_tower2.visible = true
			btn_sell.visible = false

		TowerType.SLOWER:
			btn_tower2.visible = false
			btn_sell.visible = true
			btn_sell.text = "Vendre"
			if current_level < 3:
				label.text = "Slower lvl%d" % current_level
				btn_tower1.visible = true
				btn_tower1.text = "Améliorer lvl%d" % (current_level + 1)
			else:
				label.text = "Slower lvl3 (MAX)"
				btn_tower1.visible = false

		TowerType.ANTILETTER:
			btn_tower1.visible = false
			btn_sell.visible = true
			btn_sell.text = "Vendre"
			if current_level < 3:
				label.text = "Anti Letter lvl%d" % current_level
				btn_tower2.visible = true
				btn_tower2.text = "Améliorer lvl%d" % (current_level + 1)
			else:
				label.text = "Anti Letter lvl3 (MAX)"
				btn_tower2.visible = false

func _on_btn_tower1():
	print("TURRET_SLOWER = ", TURRET_SLOWER)
	print("TURRET_ANTILETTER = ", TURRET_ANTILETTER)
	if Money.spend_gold(COSTS["Slower"][current_level]):
		if current_tower == TowerType.NONE:
			current_tower = TowerType.SLOWER
			current_level = 1
			var turret = TURRET_SLOWER.instantiate()
			get_tree().current_scene.add_child(turret)
			turret.position =  $TurretSpawn1.global_position
			turret.setType(current_tower)
			turret_node = turret
			_update_menu()
			print("area position: ", global_position)
			print("turret position: ", turret.global_position)
		elif current_tower == TowerType.SLOWER:
			current_level += 1
			if turret_node != null:
				turret_node.level_up(current_level)
				print("You bought Tower : [Slower] lvl : ", current_level, "\nFor : ", COSTS["Slower"][current_level - 1], " golds.")
				_update_menu()
	else:
		print("Your balance is : ", Money.gold, " but you need : ", COSTS["Slower"][current_level])

func _on_btn_tower2():
	print("TURRET_ANTILETTER = ", TURRET_ANTILETTER)
	if Money.spend_gold(COSTS["antiletter"][current_level]):
		if current_tower == TowerType.NONE:
			current_tower = TowerType.ANTILETTER
			current_level = 1
			var turret = TURRET_ANTILETTER.instantiate()
			get_tree().current_scene.add_child(turret)
			turret.position =  $TurretSpawn1.global_position
			turret.setType(current_tower)
			turret_node = turret
			print("area position: ", global_position)
			print("turret position: ", turret.global_position)
		elif current_tower == TowerType.ANTILETTER:
			current_level += 1
			if turret_node != null:
				turret_node.level_up(current_level)
				print("You bought Tower : [Anti Letter] lvl : ", current_level, "\nFor : ", COSTS["antiletter"][current_level - 1], " golds.")
				_update_menu()
	else:
		print("Your balance is : ", Money.gold, " but you need : ", COSTS["antiletter"][current_level])

func _on_btn_sell():
	if current_tower == TowerType.SLOWER:
		Money.add_gold(COSTS["Slower"][current_level - 1] * SELL_RATIO)
		print("Sold for : ", COSTS["Slower"][current_level - 1] * SELL_RATIO)
	elif current_tower == TowerType.ANTILETTER:
		Money.add_gold(COSTS["antiletter"][current_level - 1] * SELL_RATIO)
		print("Sold for : ", COSTS["antiletter"][current_level - 1] * SELL_RATIO)
	current_tower = TowerType.NONE
	current_level = 0
	if turret_node != null:
		turret_node.sell(current_level)
		menu.visible = false
