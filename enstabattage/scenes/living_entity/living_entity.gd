extends CharacterBody2D
class_name LivingEntity
signal died

@export var max_life = 10
@export var is_touchable = true
@export var is_enemy = false
@export var maximum_life_bar_size = 100

@onready var life = max_life
@onready var life_display = $LifeDisplay
@onready var sprite = $Sprite2D

func _ready() -> void:
	life_display.max_value = max_life
	init_life_display()

func _process(delta: float) -> void:
	sprite.flip_h = velocity.x >= 0
	update_life_display()

func _physics_process(delta: float) -> void:
	move_and_slide()
	if life <= 0:
		die()

func init_life_display():
	life_display.size.x = min(max_life * 5, maximum_life_bar_size)
	life_display.position.x = - life_display.size.x / 2
	life_display.max_value = max_life

func update_life_display():
	life_display.value = life

func deal_knockback(direction:Vector2, amount:float):
	velocity = direction * amount

func deal_damage(damager, damage_amount):
	life -= damage_amount

func die():
	died.emit()
	queue_free()

func remove():
	queue_free()
