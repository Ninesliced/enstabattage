extends LivingEntity
class_name Enemy

@export var damage = 1

@onready var animation_player = $AnimationPlayer

var rng = RandomNumberGenerator.new()

func _process(delta: float) -> void:
	super(delta)

func _on_died() -> void:
	Global.add_money(1)


func _on_hurt_box_body_entered(body:Node2D):
	if body is LivingEntity and body.is_enemy != is_enemy:
		body.deal_damage(self, damage)
		deal_knockback(Vector2(rng.randf_range(-1, 1), -1).normalized(), 50)

func flash_white():
	var tween: Tween = create_tween()
	tween.tween_property(sprite, "modulate:v", 1, 0.1).from(15)

func _on_damaged(_damager, _damage_amount):
	animation_player.play("damaged")
