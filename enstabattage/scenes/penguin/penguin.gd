extends LivingEntity

func _process(delta: float) -> void:
	pass

func _on_died() -> void:
	Global.add_money(1)
