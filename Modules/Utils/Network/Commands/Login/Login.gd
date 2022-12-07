extends Control

onready var MainMenu = $"/root/MainMenu"
onready var Global = $"/root/Global"
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func spawnMainPlayer(packet):
	var pos = Vector2(packet.value.pos.x, packet.value.pos.y)

	Global.spawnPlayer(packet.value.uuid, packet.value.username, pos)
	Global.mainUuidPlayer = packet.value.uuid;
	MainMenu.hide()
	Network.sendCommand("game:getPlayers", {})
	
	
func spawnNewPlayer(packet):
	var pos = Vector2(packet.value.pos.x, packet.value.pos.y)

	Global.spawnPlayerOnline(packet.value.uuid, packet.value.username, pos)
	
	
# Called when the node enters the scene tree for the first time.
func _ready():
#
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
