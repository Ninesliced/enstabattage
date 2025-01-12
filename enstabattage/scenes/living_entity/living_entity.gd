extends CharacterBody2D
class_name LivingEntity
signal died

@onready var life_display = $LifeDisplay
@export var max_life = 10
@onready var life = max_life

func _ready() -> void:
	life_display.max_value = max_life
	init_life_display()

func _physics_process(delta: float) -> void:
	move_and_slide()
	if life <= 0:
		die()

func init_life_display():
	life_display.size.x = max_life * 5
	life_display.position.x = - life_display.size.x / 2
	life_display.max_value = max_life

func update_life_display():
	life_display.value = life

func damage(damage_amount):
	life -= damage_amount
	update_life_display()

func die():
	died.emit()
	queue_free()

func remove():
	queue_free()
