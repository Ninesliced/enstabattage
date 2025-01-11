extends LivingEntity

@export var init_velocity = Vector2(0,0)

func _ready() -> void:
	velocity = init_velocity
