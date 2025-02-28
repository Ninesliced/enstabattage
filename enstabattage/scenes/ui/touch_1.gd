extends VBoxContainer


@export_file("*.tscn") var touch_path: String
@export var touch_texture : Texture2D
@export var price_list = [1,1,1,1,1]
@export var damage_list = [1.0,2.0,3.0,4.0,5.0]
@export var is_unlocked = false
@export var unlock_price = 100

@onready var selection_rect = %SelectionRect
@onready var lock_rect = %LockRect
@onready var button = $Button
@onready var label = $Button/MarginContainer/Label
@onready var texture_rect = $Button/MarginContainer/TextureRect
@onready var scroll_container = self.get_parent().get_parent()
@onready var lock_texture = preload("res://images/touches/touch_locked.png")

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
	texture_rect.texture = touch_texture
	update_button_display()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	selection_rect.visible = is_unlocked


func update_button_display():
	if not is_unlocked:
		label.text = "Lock \n"+str(unlock_price)+" $"
		texture_rect.texture = lock_texture
	elif level < max_level:
		label.text = "Lvl " + str(level) + "\n" + str(price_list[level]) + " $"
		texture_rect.texture = touch_texture
	else:
		label.text = "Max"

		
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


func touch_change(touch):
	touch_manager.set_touch(touch)
	scroll_container.unequiping(name)


func unequip(tab_name: Variant) -> void:
	if name != tab_name and is_unlocked:
		label.text = "Lvl " + str(level) + "\n" + " "
		unlock_price = 0
		is_unlocked = false
		
	pass # Replace with function body.
