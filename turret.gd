extends Node2D

@export var BULLET: PackedScene = null

var target: Node2D = null

@onready var gunSprite = $GunSprite
@onready var rayCast = $RayCast2D
@onready var reloadTimer = $RayCast2D/ReloadTimer


func _ready():
	await get_tree().process_frame
	target = find_target()

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
	print("PEW")
	
	if BULLET:
		var bullet: Node2D = BULLET.instantiate()
		bullet.global_rotation = rayCast.global_rotation
		get_tree().current_scene.add_child(bullet)
		bullet.global_position = global_position
		print("timer started")
	
	reloadTimer.start()

func find_target():
	var new_target: Node2D = null
	var lowest_distance = INF
	if get_tree().has_group("enemies"):
		var allEnemies: Array = get_tree().get_nodes_in_group("enemies")
		for bot in allEnemies:
			if bot == self:  # ← ignore la tourelle elle-même
				continue
			var distance = bot.global_position.distance_squared_to(gunSprite.global_position)
			if distance < lowest_distance:
				new_target = bot
				lowest_distance = distance
	return new_target
	
func _on_reload_timer_timeout():
	print("timer fini")
	rayCast.enabled = true
