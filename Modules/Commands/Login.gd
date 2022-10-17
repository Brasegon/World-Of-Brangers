extends Control

onready var MainMenu = $"/root/MainMenu"
const Global = preload("res://Modules/Global.gd")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func loginSuccess(packet):
	var global: Global = get_node("/root/Global")
	var pos = Vector2(packet.value.pos.x, packet.value.pos.y)
	global.spawnPlayer(packet.value.uuid, packet.value.username, pos)
	global.mainUuidPlayer = packet.value.uuid;
	MainMenu.hide()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
