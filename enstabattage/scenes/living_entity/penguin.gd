extends LivingEntity
@onready var sprite = $Sprite2D

func _process(delta: float) -> void:
		sprite.flip_h = velocity.x >= 0
