extends Area2D
class_name Touch
@export var damage = 1
@export var coodown_time = .2
@onready var flash = $Flash
@onready var hit_box = $HitBox
@onready var life_span_timer = $LifeSpanTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	flash.hide()
	hit_box.disabled = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body is LivingEntity and body.is_touchable:
		body.damage(self,damage)


func _on_start_timer_timeout() -> void:
	flash.show()
	hit_box.disabled = false
	life_span_timer.start()
	


func _on_life_span_timer_timeout() -> void:
	queue_free()
