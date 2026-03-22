extends Node2D
@export var TURRET: PackedScene = null
@onready var spawn_points = [$TurretSpawn1]
@onready var area = $Area2D
signal area_2d
func _ready():
	if area.current_tower
	for spawn in spawn_points:
		var turret = TURRET.instantiate()
		add_child(turret)
		turret.global_position = spawn.global_position
