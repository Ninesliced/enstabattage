extends Area2D
class_name Touch
@export var damage = 1
@export var is_enemy = false
@onready var flash = $Flash
@onready var hit_box = $HitBox

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body is LivingEntity:
		body.damage(self,damage)


func _on_start_timer_timeout() -> void:
	pass


func _on_life_span_timer_timeout() -> void:
	queue_free()

func disable_and_hide_node(node:Node) -> void:
	node.process_mode = 4 # = Mode: Disabled
	node.hide()

func enable_and_show_node(node:Node) -> void:
	node.process_mode = 0 # = Mode: Inherit
	node.show()
