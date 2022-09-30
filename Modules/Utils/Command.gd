extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var MainMenu = $"/root/MainMenu"
const Global = preload("res://Modules/Global.gd")

func loginSuccess(packet):
	var global: Global = get_node("/root/Global")
	var pos = Vector2(packet.value.pos.x, packet.value.pos.y)
	global.spawnPlayer(packet.value.uuid, packet.value.username, pos)
	MainMenu.hide()

func sendCommand(ws:WebSocketClient, command, value):
	if ws.get_peer(1).is_connected_to_host():
		ws.get_peer(1).put_var(to_json({
			"command": command,
			"value": value
		}))
	

func command(ws: WebSocketClient, packet):
	if typeof(packet) != 18:
		print("Wrong data type")
		return
	if (packet.command == "loginSuccess" && packet.value):
		loginSuccess(packet)
		

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
