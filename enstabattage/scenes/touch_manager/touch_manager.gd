extends Node2D
@export_file("*.tscn") var entity_path: String

var entity_file: PackedScene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	entity_file = load(entity_path)
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch and event.is_pressed():
		var entity = entity_file.instantiate()
		entity.position = event.position
		add_child(entity)
		pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
