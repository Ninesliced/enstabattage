extends LivingEntity
@onready var sprite = $Sprite2D

func _process(delta: float) -> void:
	sprite.flip_h = velocity.x >= 0

func _on_died() -> void:
	Global.add_money(1)
