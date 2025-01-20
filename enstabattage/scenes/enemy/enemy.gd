extends LivingEntity
class_name Enemy

@export var damage = 1
@export_file("*.tscn") var particle_path: String
@export var money_on_death = 1

@onready var animation_player = $AnimationPlayer

var rng = RandomNumberGenerator.new()
var particle_file : PackedScene

func _ready() -> void:
	super()
	particle_file = load(particle_path)

func _process(delta: float) -> void:
	super(delta)

func _on_died() -> void:
	var particle = particle_file.instantiate()
	particle.emitting = true
	get_parent().add_child(particle)
	particle.set_global_position(global_position)
	Global.add_money(money_on_death)


func _on_hurt_box_body_entered(body:Node2D):
	if body is LivingEntity and body.is_enemy != is_enemy:
		body.deal_damage(self, damage)
		var strength = 1
		if body is Tower:
			strength = knockback_resistance

		deal_knockback(Vector2(rng.randf_range(-1, 1), -1).normalized(), 50 * strength)

func flash_white():
	var tween: Tween = create_tween()
	tween.tween_property(sprite, "modulate:v", 1, 0.1).from(15)

func _on_damaged(_damager, _damage_amount):
	animation_player.play("damaged")
