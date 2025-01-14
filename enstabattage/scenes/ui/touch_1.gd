extends HBoxContainer


@export_file("*.tscn") var touch_path: String
@export var price_list = [100,200,300,400,500]
@export var damage_list = [1,2,3,4,5]
@onready var button = $Button
@onready var label = $Label

var touch_file: PackedScene
var touch
var touch_manager
var level = 0
var max_level = len(price_list)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	touch_manager = get_node("/root/Main/TouchManager")
	touch_file = load(touch_path)
	touch = touch_file.instantiate()
	label.text = touch.name
	update_button_display()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_button_display():
	button.text = str(price_list[level]) + " €"

func _on_button_pressed() -> void:
	if level < max_level and Global.money >= price_list[level]:
		Global.money -= price_list[level]
		touch.damage = damage_list[level]
		level += 1
		update_button_display()
	touch_manager.set_touch(touch)
	pass # Replace with function body.
