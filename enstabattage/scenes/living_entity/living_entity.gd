extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@export var life = 10


func _physics_process(delta: float) -> void:
	move_and_slide()


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventScreenTouch and event.is_pressed():
		life -= 1
		print(life)
		
	if life <= 0:
		die()
		
func die():
	queue_free()
