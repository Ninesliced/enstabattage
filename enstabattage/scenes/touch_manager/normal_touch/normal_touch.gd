extends Area2D
class_name Touch
@onready var flash = $Flash
@onready var hit_box = $HitBox
@onready var life_span_timer = $LifeSpanTimer
@onready var life
@export var damage = 1.0
@export var coodown_time = .2
@export var is_auto = false
@export var knockback_amount = 50
@export var screenshake = 2
var rng = RandomNumberGenerator.new()
var makes_sound = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	flash.hide()
	hit_box.disabled = true

	if makes_sound:
		$ShootSound.play()
	var camera = get_viewport().get_camera_2d()
	if camera is Camera:
		camera.shake(screenshake)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body is LivingEntity and body.is_touchable:
		body.deal_damage(self, damage)
		body.deal_knockback(Vector2(rng.randf_range(-1, 1), -1).normalized(), knockback_amount)

func _on_start_timer_timeout() -> void:
	flash.show()
	flash.play("default")
	hit_box.disabled = false
	life_span_timer.start()
	

func _on_life_span_timer_timeout() -> void:
	queue_free()
