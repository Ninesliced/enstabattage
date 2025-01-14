extends Node2D
@export_file("*.tscn") var entity_path: String
@onready var cooldown = $Cooldown

var entity_file: PackedScene
var entity
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	entity_file = load(entity_path)
	entity = entity_file.instantiate()
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if ((event is InputEventScreenTouch and event.is_pressed()) or (event is InputEventScreenDrag and entity.is_auto) ) and cooldown.is_stopped():
		var entity_copy = entity.duplicate()
		entity_copy.position = event.position
		add_child(entity_copy)
		cooldown.wait_time = entity.coodown_time
		cooldown.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_touch(touch):
	entity = touch
	pass
	
func get_touch():
	return entity
