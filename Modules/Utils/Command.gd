extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


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
	if (packet.command == "login:success" && packet.value):
		$Login.loginSuccess(packet)
		

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
