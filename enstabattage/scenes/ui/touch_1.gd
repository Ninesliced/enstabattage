extends HBoxContainer


@export_file("*.tscn") var touch_path: String
@export var price_list = [1,1,1,1,1]
@export var damage_list = [1,2,3,4,5]
@export var is_unlocked = false
@export var unlock_price = 100
@onready var button = $Button
@onready var label = $Label
@onready var scroll_container = self.get_parent().get_parent()

var touch_file: PackedScene
var touch
var touch_manager
var level = 0
var max_level = len(price_list)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(scroll_container.name)
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
	if not is_unlocked:
		button.text = "Unlock "+str(unlock_price)+" €"
	elif level < max_level:
		button.text = str(price_list[level]) + " €" +"\nLevel " + str(level)
	else:
		button.text = "Level Max"
		
func _on_button_pressed() -> void:
	if not is_unlocked and Global.money >= unlock_price:
		Global.money -= unlock_price
		is_unlocked = true
		update_button_display()
		touch_change(touch)
	elif is_unlocked:
		if level < max_level and Global.money >= price_list[level]:
			Global.money -= price_list[level]
			touch.damage = damage_list[level]
			level += 1
			update_button_display()
		touch_change(touch)
	pass # Replace with function body.

func touch_change(touch):
	touch_manager.set_touch(touch)
	scroll_container.unequiping(name)

func unequip(tab_name: Variant) -> void:
	if name != tab_name and is_unlocked:
		button.text = "Equip"
		unlock_price = 0
		is_unlocked = false
		
	pass # Replace with function body.
