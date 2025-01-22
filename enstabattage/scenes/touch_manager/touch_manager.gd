extends Node2D
@export_file("*.tscn") var entity_path: String
@onready var cooldown = $Cooldown

var entity_file: PackedScene
var entity
var finger_down = false
var last_touch_pos = Vector2(20,20)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	entity_file = load(entity_path)
	entity = entity_file.instantiate()
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	
	if event is InputEventScreenTouch: 
		finger_down = event.is_pressed()
	
	if ((event is InputEventScreenTouch and event.is_pressed()) or (event is InputEventScreenDrag and entity.is_auto)):
		
		if cooldown.is_stopped():
			spawn_touch(event.position)
			cooldown.wait_time = entity.coodown_time
			cooldown.start()
			
		last_touch_pos = event.position

func spawn_touch(touch_pos):
	var entity_copy = entity.duplicate()
	entity_copy.position = touch_pos
	add_child(entity_copy)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if cooldown.is_stopped() and finger_down and entity.is_auto:
		spawn_touch(last_touch_pos)
		cooldown.wait_time = entity.coodown_time
		cooldown.start()
	pass

func set_touch(touch):
	entity = touch
	pass
	
func get_touch():
	return entity
