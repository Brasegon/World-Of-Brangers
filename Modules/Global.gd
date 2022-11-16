extends Node2D
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#onready const players = 
# Called when the node enters the scene tree for the first time.
var mainUuidPlayer;
var mapInstance;

func createNewPlayer(uuid:String, name:String, pos:Vector2, type:bool):
	var playerClass = preload("res://Scenes/Player/Player.tscn");
	var playerInstance = playerClass.instance();
	playerInstance.setPlayerName(name)
	playerInstance.name = uuid
	playerInstance.setPlayerPos(pos)
	playerInstance.init(type);
	var players = mapInstance.get_node("World/Players");
	players.add_child(playerInstance);

func loadMaps(mapName:String):
	var mapClass = preload("res://Scenes/Maps/Lobby.tscn");
	mapInstance = mapClass.instance();
	mapInstance.name = "Map"
	add_child(mapInstance)

func spawnPlayerOnline(uuid:String, name:String, pos:Vector2):
	createNewPlayer(uuid, name, pos, true)

func spawnPlayer(uuid:String, name:String, pos:Vector2):
	loadMaps("Lobby")
	createNewPlayer("mainPlayer", name, pos, false);

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
