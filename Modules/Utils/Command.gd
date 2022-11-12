extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const PlayerMain = preload("res://Modules/Player/PlayerMain.gd")

func sendCommand(ws:WebSocketClient, command, value):
	if ws.get_peer(1).is_connected_to_host():
		ws.get_peer(1).put_var(to_json({
			"command": command,
			"value": value
		}))
	

func command(ws: WebSocketClient, packet):
	print(packet.command)
	if typeof(packet) != 18:
		print("Wrong data type")
		return
	if (packet.command == "login:success" && packet.value):
		$Login.loginSuccess(packet)
	if (packet.command == "login:newplayer" && packet.value):
		$Login.spawnNewPlayer(packet)
	if (packet.command == "move" && packet.value):
		print(packet.value)
		var player: PlayerMain = get_node("/root/Global/Players/" + packet.value.uuid)
		player.setPlayerPos(Vector2(packet.value.pos.x, packet.value.pos.y))
		player.animation_otherPlayer(packet.value.direction)
	if (packet.command == "login:disconnectPlayer" && packet.value):
		var player: PlayerMain = get_node("/root/Global/Players/" + packet.value.uuid)
		player.queue_free()
		

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
