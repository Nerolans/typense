extends Area2D

enum TowerType { NONE, FIRE, ANTILETTER }
var current_tower: TowerType = TowerType.NONE
var current_level: int = 0
var turret_node = null
const COSTS = {
	"fire": [100, 150, 200],
	"antiletter": [120, 180, 250]
}
const SELL_RATIO = 0.5

@onready var menu = $"CanvasLayer/PanelContainer"
@onready var label = $"CanvasLayer/PanelContainer/VBoxContainer/Label"
@onready var btn_tower1 = $"CanvasLayer/PanelContainer/VBoxContainer/HBoxContainer/BtnTower1"
@onready var btn_tower2 = $"CanvasLayer/PanelContainer/VBoxContainer/HBoxContainer/BtnTower2"
@onready var btn_sell = $"CanvasLayer/PanelContainer/VBoxContainer/HBoxContainer/BtnSell"
@onready var gold_label = $"CanvasLayer/GoldLabel"
@export var TURRET_FIRE: PackedScene = null  
@onready var spawn_points = [$TurretSpawn1]    



func _ready():
	input_pickable = true
	input_event.connect(_on_input_event)
	menu.visible = false
	btn_tower1.pressed.connect(_on_btn_tower1)
	btn_tower2.pressed.connect(_on_btn_tower2)
	btn_sell.pressed.connect(_on_btn_sell)
	gold_label.text = "Or : %d" % Money.gold
	Money.gold_changed.connect(_on_gold_changed)
	
func _on_gold_changed(new_amount):
	gold_label.text = "Or : %d" % new_amount

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			_open_menu()

func _open_menu():
	menu.visible = true
	_update_menu()

func _update_menu():
	match current_tower:
		TowerType.NONE:
			label.text = "Choose a Turret"
			btn_tower1.text = "Fire lvl1"
			btn_tower2.text = "Anti Letter lvl1"
			btn_tower1.visible = true
			btn_tower2.visible = true
			btn_sell.visible = false

		TowerType.FIRE:
			btn_tower2.visible = false
			btn_sell.visible = true
			btn_sell.text = "Vendre"
			if current_level < 3:
				label.text = "Fire lvl%d" % current_level
				btn_tower1.visible = true
				btn_tower1.text = "Améliorer lvl%d" % (current_level + 1)
			else:
				label.text = "Fire lvl3 (MAX)"
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
	if Money.spend_gold(COSTS["fire"][current_level]):
		if current_tower == TowerType.NONE:
			current_tower = TowerType.FIRE
			current_level = 1
			var turret = TURRET_FIRE.instantiate()
			get_tree().current_scene.add_child(turret)
			turret.position =  $TurretSpawn1.global_position
			turret_node = turret
			print("area position: ", global_position)
			print("turret position: ", turret.global_position)
		elif current_tower == TowerType.FIRE:
			current_level += 1
			if turret_node != null:
				turret_node.level_up(current_level)
				print("You bought Tower : [Fire] lvl : ", current_level, "\nFor : ", COSTS["fire"][current_level - 1], " golds.")
				_update_menu()
	else:
		print("Your balance is : ", Money.gold, " but you need : ", COSTS["fire"][current_level])

func _on_btn_tower2():
	if Money.spend_gold(COSTS["antiletter"][current_level]):
		if current_tower == TowerType.NONE:
			current_tower = TowerType.ANTILETTER
			current_level = 1
		elif current_tower == TowerType.ANTILETTER:
			current_level += 1
			if turret_node != null:
				turret_node.level_up(current_level)
				print("You bought Tower : [Anti Letter] lvl : ", current_level, "\nFor : ", COSTS["antiletter"][current_level - 1], " golds.")
				_update_menu()
	else:
		print("Your balance is : ", Money.gold, " but you need : ", COSTS["antiletter"][current_level])

func _on_btn_sell():
	if current_tower == TowerType.FIRE:
		Money.add_gold(COSTS["fire"][current_level - 1] * SELL_RATIO)
		print("Sold for : ", COSTS["fire"][current_level - 1] * SELL_RATIO)
	elif current_tower == TowerType.ANTILETTER:
		Money.add_gold(COSTS["antiletter"][current_level - 1] * SELL_RATIO)
		print("Sold for : ", COSTS["antiletter"][current_level - 1] * SELL_RATIO)
	current_tower = TowerType.NONE
	current_level = 0
	if turret_node != null:
		turret_node.sell(current_level)
		menu.visible = false
