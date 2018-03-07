extends Node2D

onready var localButton = Button.new()
onready var networkButton = Button.new()

func _ready():
	$OnePlayerButton.connect("button_down", self, "one_player_clicked")
	$TwoPlayerButton.connect("button_down", self, "two_player_clicked")
	$How2PlayButton.connect("button_down", self, "how_to_play_clicked")
	$OptionsButton.connect("button_down", self, "options_clicked")
	
	localButton.text = "Local Game"
	localButton.set_size(Vector2(256, 32))
	localButton.set_position(Vector2(384, 320))
	localButton.connect("button_down", self, "local_game_clicked")
	
	networkButton.text = "Network Game"
	networkButton.set_size(Vector2(256, 32))
	networkButton.set_position(Vector2(384, 355))
	networkButton.connect("button_down", self, "network_game_clicked")

func network_game_clicked():
	print("NETNTNTNTNT")

func local_game_clicked():
	get_tree().change_scene("res://Arena.tscn")

func one_player_clicked():
	print("CLICKS")

func two_player_clicked():
	remove_child($OnePlayerButton)
	remove_child($TwoPlayerButton)
	remove_child($How2PlayButton)
	remove_child($OptionsButton)
	
	add_child(localButton)
	add_child(networkButton)
	
func how_to_play_clicked():
	print("Clisk4eva")
	
func options_clicked():
	print("yup yup")