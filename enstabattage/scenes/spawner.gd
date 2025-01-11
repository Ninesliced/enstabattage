extends Node2D

@export_file("*.tscn") var entity_path: String
@export var spawn_radius: float = 0.0
@export_range(-360, 360, 0.1, "radians_as_degrees") var minimum_angle: float = 0.0
@export_range(-360, 360, 0.1, "radians_as_degrees") var maximum_angle: float = 0.0
@export var minimum_velocity = 1.0
@export var maximum_velocity = 2.0

@onready var spawn_timer = $SpawnTimer

var rng = RandomNumberGenerator.new()

var entity_file: PackedScene
func _ready():
	rng.randomize()
	entity_file = load(entity_path)

func _spawn_entity():
	var entity = entity_file.instantiate()
	var pos = Vector2(rng.randf_range(0, spawn_radius), 0).rotated(rng.randf_range(0, TAU))
	var angle = rng.randf_range(minimum_angle, maximum_angle)
	var vel = rng.randf_range(minimum_velocity, maximum_velocity)

	entity.position = pos
	entity.velocity = Vector2(vel, 0).rotated(angle)
	add_child(entity)

func _on_spawn_timer_timeout():
	_spawn_entity()
