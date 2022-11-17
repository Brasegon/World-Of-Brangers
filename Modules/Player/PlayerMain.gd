extends KinematicBody2D


onready var animationPlayer = $AnimationPlayer
var positionAnim = 0
const SPEED = 100
const TIME_OF_PACKET = 0.01
var playerVelocity = Vector2.ZERO
var playerPosition = Vector2.ZERO
var okToSend = true
var timer = 0
var playerIsMove = false
var isNetworkPlayer = false

func idle_anim():
	if (positionAnim == 1):
		animationPlayer.play("Idle_Right")
	elif (positionAnim == 0):
		animationPlayer.play("Idle_Left")

func animation_player_x():
	if (playerVelocity.x > 0):
		playerIsMove = true
		animationPlayer.play("Walk_right")
		positionAnim = 1
	elif (playerVelocity.x < 0):
		playerIsMove = true
		animationPlayer.play("Walk_left")
		positionAnim = 0
	elif (playerVelocity.x == 0 and playerVelocity.y != 0 and positionAnim):
		playerIsMove = true
		animationPlayer.play("Walk_right")
	elif (playerVelocity.x == 0 and playerVelocity.y != 0 and !positionAnim):
		playerIsMove = true
		animationPlayer.play("Walk_left")

func animation_otherPlayer(type):
	if (type == 1):
		positionAnim = 1
		animationPlayer.play("Walk_right")
	if (type == 2):
		animationPlayer.play("Walk_left")
		positionAnim = 0

func animation_player():
	if (playerVelocity.y > 0):
		animation_player_x()
	elif (playerVelocity.y < 0):
		animation_player_x()
	elif (playerVelocity.y == 0):
		animation_player_x()


func _physics_process(delta):
	if !isNetworkPlayer:
		playerVelocity.x = (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"))
		playerVelocity.y = (Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up"))
		animation_player()
	if (playerVelocity.x == 0 && playerVelocity.y == 0 && playerIsMove):
		animationPlayer.stop()
		playerIsMove = false
	if (!animationPlayer.current_animation == "Walk_right" && !animationPlayer.current_animation == "Walk_left"):
		idle_anim()
	playerVelocity = move_and_slide(playerVelocity * SPEED)
	if (okToSend == false):
		timer += delta
	if (timer >= TIME_OF_PACKET):
		okToSend = true
		timer = 0
	if ((playerVelocity.x != 0 or playerVelocity.y != 0) and okToSend):
		Network.sendCommand("move", {
			"x": global_transform.origin.x,
			"y": global_transform.origin.y,
			"direction": playerVelocity.x
		})
		okToSend = false;
	setPlayerPos(global_transform.origin)

func getPlayerPos():
	return playerVelocity;

func setPlayerName(playerNames:String):
	var playerName:RichTextLabel = get_node("playerNameIndex/playerName")
	playerName.bbcode_text = playerName.bbcode_text.replace("{playerName}", playerNames)
	print(playerName.bbcode_text)

func setPlayerPos(playerPosSet):
	global_transform.origin = playerPosSet;
	playerPosition = global_transform.origin;

func init(networkPlayer:bool):
	isNetworkPlayer = networkPlayer
	if networkPlayer:
		$Camera2D.current = false;
	#ID = Network.getIdentifierPlayer()
	print(playerPosition)
	

func _ready():
	Logger.info("Player spawned at pos x=%s y=%s" % [playerVelocity.x, playerVelocity.y])
	pass # Replace with function body.
