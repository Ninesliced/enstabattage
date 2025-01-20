extends Control

func set_player_name(player_name: String):
	%Name.text = player_name

func set_rank(rank: int):
	%Rank.text = str(rank) + "."

func set_score(score: int):
	%Score.text = str(score)

func set_list(list: String):
	%List.text = list

func parse_data(item):
	var player_name: String = item.player.name
	var list: String = "???"
	
	var full_name = Leaderboard._get_full_name(player_name, str(item.player.public_uid), "???")
	player_name = full_name[0]
	list = full_name[1]

	var rank = item.rank
	var score = item.score

	set_player_name(player_name)
	set_rank(rank)
	set_score(score)
	set_list(list)
