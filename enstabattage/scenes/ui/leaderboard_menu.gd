extends Menu

func _ready():
    Leaderboard.leaderboard_recieved.connect(_on_leaderboard_recieved)

func _on_menu_set():
    Leaderboard.get_leaderboards()

func _on_leaderboard_recieved(data):
    print("RECIEVED LEADERBOARDS: ", data)
    