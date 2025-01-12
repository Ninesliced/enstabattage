extends CharacterBody2D
class_name LivingEntity
signal died

@onready var life_display = $LifeDisplay
@export var max_life = 10
var life = max_life

func _ready() -> void:
	life_display.max_value = max_life
	init_life_display()

func _physics_process(delta: float) -> void:
	move_and_slide()
	
	if life <= 0:
		die()


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventScreenTouch and event.is_pressed():
		life -= 1
		print(life)
		
	update_life_display()
		
func init_life_display():
	life_display.size.x = max_life * 5
	life_display.position.x = - life_display.size.x / 2
		
func update_life_display():
	life_display.value = life
		
func die():
	died.emit()
	print("qsjgdh")
	queue_free()
