extends Control

onready var playerName = $Panel/playerName
onready var joinButton = $Panel/joinButton
onready var Connection = $Connection
onready var Global = $"/root/Global"
onready var Network = $"/root/Network"
var player = null
var buttonJoinPressed = false;
var playerConnected = false;


func connectServer(success:bool):
	if (success):
		Network.sendCommand("login:connect", {
			"username": playerName.text
		})
	else:
		buttonJoinPressed = false;
		joinButton.text = "Join"
		joinButton.disabled = false
		$Panel.show()
		Connection.hide()
		

func _process(delta):
	if Network.isConnected && !playerConnected:
		playerConnected = true;
		
		
	
func _physics_process(delta):
	if (joinButton.pressed && !buttonJoinPressed):
		buttonJoinPressed = true;
		joinButton.text = "Connexion en cours..."
		joinButton.disabled = true
		Connection.show()
		$Panel.hide()
		Network.connectServer()
		
