extends Node2D
@export_file("*.tscn") var entity_path: String
@onready var cooldown = $Cooldown

var entity_file: PackedScene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	entity_file = load(entity_path)
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch and event.is_pressed() and cooldown.is_stopped():
		var entity = entity_file.instantiate()
		entity.position = event.position
		add_child(entity)
		cooldown.wait_time = entity.coodown_time
		cooldown.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(cooldown.time_left)
	pass
