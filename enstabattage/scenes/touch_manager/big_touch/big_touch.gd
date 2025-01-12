extends Touch
@onready var aim_indicator = $AimIndicator


func _on_start_timer_timeout() -> void:
	super()
	aim_indicator.hide()
	
