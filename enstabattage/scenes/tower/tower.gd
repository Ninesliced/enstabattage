extends LivingEntity
class_name Tower

func _on_died():
	Global.game_over()
