extends Node2D
enum TowerType { NONE, SLOWER, ANTILETTER }
@export var BULLET: PackedScene = null
@onready var screensize  = get_viewport_rect().size
@onready var gunSprite = $GunSprite
@onready var rayCast = $RayCast2D
@onready var reloadTimer = $RayCast2D/ReloadTimer
var level = 1
var target: Node2D = null
var turret_type : TowerType = TowerType.NONE
var type_string : String = ""

	
func _ready():
	await get_tree().process_frame
	bullet_atribution()
	target = find_target()
	if type_string == "Slower":
		gunSprite.play("slow1")
	if type_string == "Antiletter":
		gunSprite.play("antiletter1") 
func _physics_process(_delta):
	target = find_target()  
	
	if target != null:
		var angle_to_target: float = global_position.direction_to(target.global_position).angle()
		rayCast.global_rotation = angle_to_target
		rayCast.target_position = Vector2(200, 0) 
		
		if rayCast.is_colliding():
			var collider = rayCast.get_collider()
			
			if collider and (collider.is_in_group("enemies") or collider.get_parent().is_in_group("enemies")):
				gunSprite.rotation = angle_to_target+3.1415/2
				if reloadTimer.is_stopped():
					shoot()
					

func shoot():
	
	
	if BULLET:
		var bullet: Node2D = BULLET.instantiate()
		bullet.global_rotation = rayCast.global_rotation
		bullet.set_bulletType(type_string)
		get_tree().current_scene.add_child(bullet)
		bullet.global_position = global_position
		
		
	
	reloadTimer.start()

func find_target():
	var new_target: Node2D = null
	var lowest_distance = INF
	if get_tree().has_group("enemies"):
		var allEnemies: Array = get_tree().get_nodes_in_group("enemies")
		for bot in allEnemies:
			if bot == self: 
				continue
			var distance = bot.global_position.distance_squared_to(gunSprite.global_position)
			if distance < lowest_distance:
				new_target = bot
				lowest_distance = distance
	return new_target
	
func _on_reload_timer_timeout():
	rayCast.enabled = true

func level_up(new_level: int):
	if type_string == "Slower":
		if new_level == 1:
			reloadTimer.wait_time = 2.5
			gunSprite.play("slow1")
		if new_level == 2:
			reloadTimer.wait_time = 1.0
			gunSprite.play("slow2")
		elif new_level == 3:
			reloadTimer.wait_time = 0.3
			gunSprite.play("slow3")
	if type_string == "Antiletter":
		if new_level == 1:
			reloadTimer.wait_time = 2.5
			gunSprite.play("antiletter1")
		if new_level == 2:
			reloadTimer.wait_time = 1.0
			gunSprite.play("antiletter2")
		if new_level == 3:
			reloadTimer.wait_time = 0.3
			gunSprite.play("antiletter3")
func sell(new_level: int):
	queue_free()
func setType(newturret_type : TowerType):
	turret_type = newturret_type
	if	turret_type == TowerType.SLOWER:
		gunSprite.play("slow1")
	if	turret_type == TowerType.ANTILETTER:
		gunSprite.play("antiletter1")
func bullet_atribution():
	if turret_type == TowerType.SLOWER:
		type_string = "Slower"
	if turret_type == TowerType.ANTILETTER:
		type_string = "Antiletter"
		
		
