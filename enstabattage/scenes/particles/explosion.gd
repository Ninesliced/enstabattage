extends AnimationPlayer

func _input(event):
    if event.is_action_pressed("ui_accept"):
        play("explosion")