extends CharacterBody2D
class_name LivingEntity
signal died

@export var max_life = 10
@onready var life = max_life
@export var is_touchable = true

@onready var life_display = $LifeDisplay
@onready var sprite = $Sprite2D

func _ready() -> void:
	life_display.max_value = max_life
	init_life_display()

func _process(delta: float) -> void:
	sprite.flip_h = velocity.x >= 0

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

func damage(damager, damage_amount):
	life -= damage_amount
	update_life_display()

func die():
	died.emit()
	queue_free()

func remove():
	queue_free()
