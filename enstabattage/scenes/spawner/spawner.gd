extends Node2D
class_name Spawner

@export_file("*.tscn") var entity_path: String
@export var spawn_radius: float = 10.0
@export_range(-360, 360, 0.1, "radians_as_degrees") var minimum_angle: float = PI/2 - PI/4
@export_range(-360, 360, 0.1, "radians_as_degrees") var maximum_angle: float = PI/2 + PI/4
@export_range(0, 135, 0.1) var x_pos: float = 67.5
@export var minimum_velocity = 10
@export var maximum_velocity = 20
@export var minimum_delay = 0.5
@export var maximum_delay = 1.0
@export var time_before_spawning_start = 10.0
@export var spawn_duration = 10.0

@onready var spawn_timer: Timer = $SpawnTimer
@onready var spawn_delay: Timer = $SpawnDelay
@onready var span_timer: Timer = $SpanTimer

var rng = RandomNumberGenerator.new()

var entity_file: PackedScene
func _ready():
	rng.randomize()
	entity_file = load(entity_path)
	spawn_delay.wait_time = time_before_spawning_start
	span_timer.wait_time = spawn_duration
	position = Vector2(x_pos,-10)

func _spawn_entity():
	var entity = entity_file.instantiate()
	var pos = Vector2(rng.randf_range(0, spawn_radius), 0).rotated(rng.randf_range(0, TAU))
	var angle = rng.randf_range(minimum_angle, maximum_angle)
	var vel = rng.randf_range(minimum_velocity, maximum_velocity)
	print(entity.name)
	entity.global_position = pos + position
	entity.max_life *= Global.difficulty
	entity.money_on_death *= Global.difficulty
	entity.velocity = Vector2(vel, 0).rotated(angle)
	get_parent().add_child(entity)

func _on_spawn_timer_timeout():
	_spawn_entity()
	_init_timer()

func _init_timer():
	spawn_timer.wait_time = rng.randf_range(minimum_delay, maximum_delay)
	spawn_timer.start()

func _on_spawn_delay_timeout() -> void:
	spawn_timer.emit_signal("timeout")
	_init_timer()
	span_timer.start()
	pass # Replace with function body.
	
func start_round():
	spawn_delay.start()

func _on_span_timer_timeout() -> void:
	spawn_timer.stop()
	pass # Replace with function body.
