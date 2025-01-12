extends Control

@onready var score_display: Label = %ScoreDisplay 

func _ready():
	pass 

func _process(_delta):
	score_display.text = "{0}€".format([Global.money])


func _on_pause_button_pressed():
	Global.menu_manager.pause()
