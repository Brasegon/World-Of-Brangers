extends KinematicBody2D


onready var animationPlayer = $AnimationPlayer
var positionAnim = 0
const SPEED = 200
const TIME_OF_PACKET = 0.01
var playerVelocity = Vector2.ZERO
var playerPosition = Vector2.ZERO
var okToSend = true
var timer = 0
var playerIsMove = false
var isWalking = false
var isIdle = true
var changePosition = false;
var isNetworkPlayer = false;
var tmpVelocity = Vector2.ZERO;

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

func animation_otherPlayer(velocity):
	playerVelocity.x = velocity.x;
	playerVelocity.y = velocity.y;

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
	move_and_slide(playerVelocity * SPEED)
	if (playerVelocity != tmpVelocity):
		changePosition = true
	if (!isNetworkPlayer and changePosition):
		tmpVelocity = playerVelocity;
		Network.sendCommand("player:move", {
			"x": playerVelocity.x,
			"y":  playerVelocity.y,
			"pos": {
				"x": global_position.x,
				"y": global_position.y
			}
		})
		changePosition = false;
	setPlayerPos(global_position)

func getPlayerPos():
	return playerVelocity;

func setPlayerName(playerNames:String):
	var playerName:RichTextLabel = get_node("playerNameIndex/playerName")
	playerName.bbcode_text = playerName.bbcode_text.replace("{playerName}", playerNames)
	print(playerName.bbcode_text)

func setPlayerPos(playerPosSet):
	global_position = playerPosSet;
	playerPosition =  global_position;

func init(networkPlayer:bool):
	isNetworkPlayer = networkPlayer
	if networkPlayer:
		$Camera2D.current = false;

func _ready():
	Logger.info("Player spawned at pos x=%s y=%s" % [playerVelocity.x, playerVelocity.y])
	var http = Network.get_node("Http")
	http.test123()
	pass # Replace with function body.
