extends Camera2D
class_name Camera

var shake_amount = 0.0
var shake_decrease_speed = 6.0

var _rng = RandomNumberGenerator.new()


func _ready():
    pass


func _process(delta):
    _update_shake(delta)

    if Input.is_action_just_pressed("ui_accept"):
        shake(10)


func _update_shake(delta):
    shake_amount = max(0.0, shake_amount - delta * shake_decrease_speed)

    offset = Vector2(_rng.randf_range(0, shake_amount), 0).rotated(_rng.randf_range(0, TAU)).round()


func shake(value):
    shake_amount = max(shake_amount, value)