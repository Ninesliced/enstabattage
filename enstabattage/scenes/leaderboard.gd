extends Node

signal authenticated
signal authenticated_error
signal leaderboard_recieved
signal score_submitted
signal player_set_name_completed
signal player_get_name_completed(name: String)

# Use this game API key if you want to test it with a functioning leaderboard
# "987dbd0b9e5eb3749072acc47a210996eea9feb0"
var game_API_key = "dev_097a88c869264a5c93407d9518a3241b"
var development_mode = true
var leaderboard_key = "best_score"
var session_token = ""
var score = 0

# HTTP Request node can only handle one call per node
var auth_http = HTTPRequest.new()
var leaderboard_http = HTTPRequest.new()
var submit_score_http = HTTPRequest.new()

var set_name_http = HTTPRequest.new()
var get_name_http = HTTPRequest.new()

func _ready():
	process_mode = PROCESS_MODE_ALWAYS

func _process(_delta):
	pass
	# if(Input.is_action_just_pressed("ui_up")):
	# 	score += 1
	# 	print("CurrentScore:"+str(score))
	
	# if(Input.is_action_just_pressed("ui_down")):
	# 	score -= 1
	# 	print("CurrentScore:"+str(score))
	
	# Upload score when pressing enter
	# if(Input.is_action_just_pressed("ui_accept")):
	# 	get_player_name()
	
	# Get score when pressing spacebar
	# if(Input.is_action_just_pressed("ui_select")):
	# 	change_player_name("test")


func authenticate():
	# Check if a player session exists
	var player_session_exists = false
	var player_identifier : String
	var file = FileAccess.open("user://LootLocker.data", FileAccess.READ)
	if file != null:
		player_identifier = file.get_as_text()
		print("player ID="+player_identifier)
		file.close()
 
	if player_identifier != null and player_identifier.length() > 1:
		print("player session exists, id="+player_identifier)
		player_session_exists = true

	if player_identifier.length() > 1:
		player_session_exists = true
		
	## Convert data to json string:
	var data = { "game_key": game_API_key, "game_version": "0.0.0.1", "development_mode": true }
	
	# If a player session already exists, send with the player identifier
	if player_session_exists:
		data = { "game_key": game_API_key, "player_identifier":player_identifier, "game_version": "0.0.0.1", "development_mode": true }
	
	# Add 'Content-Type' header:
	var headers = ["Content-Type: application/json"]
	
	# Create a HTTPRequest node for authentication
	auth_http = HTTPRequest.new()
	add_child(auth_http)
	auth_http.request_completed.connect(_on_authentication_request_completed)
	auth_http.request("https://api.lootlocker.io/game/v2/session/guest", headers, HTTPClient.METHOD_POST, JSON.stringify(data))

	print("authenticate: Sending ", data)


func _on_authentication_request_completed(_result, _response_code, _headers, body):
	print("_on_authentication_request_completed called")
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var data = json.get_data()
	
	# Print server response
	print(data)

	if not data["success"]:
		print("ERROR: ", data["error"])
		authenticated_error.emit(data)
		return

	# Save the player_identifier to file
	var file = FileAccess.open("user://LootLocker.data", FileAccess.WRITE)
	file.store_string(data.player_identifier)
	file.close()
	
	# Save session_token to memory
	session_token = data.session_token
	
	# Clear node
	auth_http.queue_free()
	# Get leaderboards
	authenticated.emit(data)


func get_leaderboards():
	print("Getting leaderboards")
	var url = "https://api.lootlocker.io/game/leaderboards/"+leaderboard_key+"/list?count=10"
	var headers = ["Content-Type: application/json", "x-session-token:"+session_token]
	
	# Create a request node for getting the highscore
	leaderboard_http = HTTPRequest.new()
	add_child(leaderboard_http)
	leaderboard_http.request_completed.connect(_on_leaderboard_request_completed)
	
	# Send request
	leaderboard_http.request(url, headers, HTTPClient.METHOD_GET, "")

func _on_leaderboard_request_completed(_result, _response_code, _headers, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var data = json.get_data()

	# Print data
	print("_on_leaderboard_request_completed", json.get_data())
	
	# Formatting as a leaderboard
	var leaderboardFormatted = ""
	if data.items:
		for n in data.items.size():
			leaderboardFormatted += str(data.items[n].rank)+str(". ")
			leaderboardFormatted += str(data.items[n].player.id)+str(" - ")
			leaderboardFormatted += str(data.items[n].score)+str("\n")
	# Print the formatted leaderboard to the console
	print(leaderboardFormatted)
	
	# Clear node
	leaderboard_http.queue_free()
	leaderboard_recieved.emit(data)


func upload_score(score: int):
	var data = { "score": str(score) }
	var headers = ["Content-Type: application/json", "x-session-token:"+session_token]
	submit_score_http = HTTPRequest.new()
	add_child(submit_score_http)
	submit_score_http.request_completed.connect(_on_upload_score_request_completed)
	# Send request
	submit_score_http.request("https://api.lootlocker.io/game/leaderboards/"+leaderboard_key+"/submit", headers, HTTPClient.METHOD_POST, JSON.stringify(data))
	# Print what we're sending, for debugging purposes:
	print(data)


func _on_upload_score_request_completed(_result, _response_code, _headers, body) :
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	
	# Print data
	print(json.get_data())
	
	# Clear node
	submit_score_http.queue_free()
	score_submitted.emit(json.get_data())


func is_name_valid(new_name: String):
	if new_name.length() == 0:
		return false

	var re = RegEx.new()
	re.compile("^[A-Za-zÀ-ÖØ-öø-ÿ0-9_-]+$")
	var result = re.search(new_name)
	if not result:
		return false
	
	return true


func change_player_name(new_name: String):
	print("Changing player name")
	
	var data = { "name": str(new_name) }
	var url =  "https://api.lootlocker.io/game/player/name"
	var headers = ["Content-Type: application/json", "x-session-token:"+session_token]
	
	# Create a request node for getting the highscore
	set_name_http = HTTPRequest.new()
	add_child(set_name_http)
	set_name_http.request_completed.connect(_on_player_set_name_request_completed)
	# Send request
	set_name_http.request(url, headers, HTTPClient.METHOD_PATCH, JSON.stringify(data))

func _on_player_set_name_request_completed(_result, _response_code, _headers, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	
	# Print data
	print("_on_player_set_name_request_completed ", json.get_data())
	set_name_http.queue_free()

	player_set_name_completed.emit(json.get_data())


func get_player_name():
	print("Getting player name")
	var url = "https://api.lootlocker.io/game/player/name"
	var headers = ["Content-Type: application/json", "x-session-token:"+session_token]
	
	# Create a request node for getting the highscore
	get_name_http = HTTPRequest.new()
	add_child(get_name_http)
	get_name_http.request_completed.connect(_on_player_get_name_request_completed)
	# Send request
	get_name_http.request(url, headers, HTTPClient.METHOD_GET, "")


func _on_player_get_name_request_completed(_result, _response_code, _headers, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	
	# Print data
	print("_on_player_get_name_request_completed", json.get_data())
	player_get_name_completed.emit(json.get_data().name)
