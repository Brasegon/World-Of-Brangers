extends Node2D
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var players = $Players
# Called when the node enters the scene tree for the first time.
var mainUuidPlayer;

func spawnPlayerOnline(uuid:String, name:String, pos:Vector2):
	var playerClass = preload("res://Scenes/Player/Player.tscn");
	var playerInstance = playerClass.instance();
	playerInstance.setPlayerName(name)
	playerInstance.name = uuid
	playerInstance.setPlayerPos(pos)
	playerInstance.init(true);
	players.add_child(playerInstance);

func spawnPlayer(uuid:String, name:String, pos:Vector2):
	var playerClass = preload("res://Scenes/Player/Player.tscn");
	var playerInstance = playerClass.instance();
	playerInstance.setPlayerName(name)
	playerInstance.name = "mainPlayer"
	playerInstance.setPlayerPos(pos)
	playerInstance.init(false);
	players.add_child(playerInstance);

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
