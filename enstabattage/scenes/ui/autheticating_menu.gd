extends Menu

var timer = 0.0

func _process(delta):
    timer += delta

    %Label.text = "Connexion"
    for i in range(3):
        if i <= int(ceil(timer)) % 3:
            %Label.text = %Label.text + "."
        else:
            %Label.text = %Label.text + " "

func _on_play_offline_pressed():
    Global.menu_manager.exit_menu()