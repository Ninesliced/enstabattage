extends Node2D
@export_file("*.tscn") var entity_path: String
@export var shot_number = 5
@export var coodown_time = .1
@export var shot_radius = 30
@export var is_auto = false
@export var damage = 1

var rng = RandomNumberGenerator.new()

var entity_file: PackedScene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	entity_file = load(entity_path)
	for i in range(shot_number):
		var entity = entity_file.instantiate()
		entity.position = Vector2(rng.randf_range(0, shot_radius), 0).rotated(rng.randf_range(0, TAU))
		entity.damage = damage
		add_child(entity)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
