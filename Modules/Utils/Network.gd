extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


onready var ws = WebSocketClient.new()
var isConnected = false;

# Called when the node enters the scene tree for the first time.

func getIdentifierPlayer():
	return;






func _connection_established(protocol):
	print("Connection established with protocol: ", protocol)
	isConnected = true;
	MainMenu.connectServer(true)

	
func _connection_closed():
	
	print("Connection closed")

func _connection_error():
	MainMenu.connectServer(false)
	print("Connection error")

func sendCommand(command, value):
	$Command.sendCommand(ws, command, value)

func connectServer():
	ws.connect("connection_established", self, "_connection_established")
	ws.connect("connection_closed", self, "_connection_closed")
	ws.connect("connection_error", self, "_connection_error")
	
	var url = "ws://localhost:8080"
	print("Connecting to " + url)
	ws.connect_to_url(url) # Replace with function body.

func _process(delta):
	if ws.get_connection_status() == ws.CONNECTION_CONNECTING || ws.get_connection_status() == ws.CONNECTION_CONNECTED:
		ws.poll()
	if ws.get_peer(1).is_connected_to_host():
		if ws.get_peer(1).get_available_packet_count() > 0:
			var packet = ws.get_peer(1).get_var()
			print(parse_json(packet))
			$Command.command(ws, parse_json(packet));

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
