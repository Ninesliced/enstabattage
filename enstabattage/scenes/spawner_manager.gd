extends Node2D
@onready var next_round_timer = $NextRoundTimer

var rounds
var round_number = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rounds = []
	next_round_timer.wait_time = .1
	next_round_timer.start()
	for child in self.get_children():
		if child is Node2D:
			rounds.append(child)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_next_round_timer_timeout() -> void:
	var round = rounds[round_number]
	var spawners = round.get_children()
	for spawner in spawners:
		spawner.start_round()
		print(spawner.name)
	next_round_timer.wait_time = round.round_time
	next_round_timer.start()
	
	round_number += 1
	pass # Replace with function body.


func _on_skip_to_next_round_pressed() -> void:
	Global.money += round(next_round_timer.time_left / 2)
	next_round_timer.emit_signal("timeout")
	pass # Replace with function body.
