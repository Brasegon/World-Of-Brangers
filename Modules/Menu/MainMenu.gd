extends Control

onready var playerName = $playerName
onready var joinButton = $joinButton
onready var Global = $"/root/Global"
onready var Network = $"/root/Network"
var player = null
var buttonJoinPressed = false;
var playerConnected = false;

func connectServer(success:bool):
	if (success):
		Network.sendCommand("sendLogin", {
			"username": playerName.text
		})
	else:
		buttonJoinPressed = false;
		joinButton.text = "Join"
		joinButton.disabled = false

func _process(delta):
	if Network.isConnected && !playerConnected:
		playerConnected = true;
		
		
	
func _physics_process(delta):
	if (joinButton.pressed && !buttonJoinPressed):
		buttonJoinPressed = true;
		joinButton.text = "Connexion en cours..."
		joinButton.disabled = true
		Network.connectServer()
		
