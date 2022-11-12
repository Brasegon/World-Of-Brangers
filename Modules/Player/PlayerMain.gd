extends KinematicBody2D


onready var animationPlayer = $AnimationPlayer
var positionAnim = 0
const SPEED = 10000
var playerVelocity = Vector2.ZERO
var playerPosition = Vector2.ZERO
var isNetworkPlayer = false

func animation_player_x():
	if (playerVelocity.x > 0):
		animationPlayer.play("Walk_right")
		positionAnim = 1
	elif (playerVelocity.x < 0):
		animationPlayer.play("Walk_left")
		positionAnim = 0
	elif (playerVelocity.x == 0 and playerVelocity.y != 0 and positionAnim):
		animationPlayer.play("Walk_right")
	elif (playerVelocity.x == 0 and playerVelocity.y != 0 and !positionAnim):
		animationPlayer.play("Walk_left")

func animation_player():
	if (playerVelocity.y > 0):
		animation_player_x()
	elif (playerVelocity.y < 0):
		animation_player_x()
	elif (playerVelocity.y == 0):
		animation_player_x()


func _physics_process(delta):
	if !isNetworkPlayer:
		playerVelocity.x = (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")) * SPEED
		playerVelocity.y = (Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")) * SPEED
		animation_player()
	if (playerVelocity.x != 0 or playerVelocity.y != 0):
		playerVelocity = move_and_slide(playerVelocity * delta)
		setPlayerPos(global_transform.origin)

func getPlayerPos():
	return playerVelocity;

func setPlayerName(playerNames:String):
	var playerName:RichTextLabel = get_node("playerName")
	playerName.bbcode_text = playerName.bbcode_text.replace("{playerName}", playerNames)
	print(playerName.bbcode_text)

func setPlayerPos(playerPosSet):
	global_transform.origin = playerPosSet;
	playerPosition = global_transform.origin;
	Network.sendCommand("move", "{x: "+String(playerPosition.x)+", y: "+String(playerPosition.y)+"}")

func init(networkPlayer:bool):
	isNetworkPlayer = networkPlayer
	if networkPlayer:
		$Camera2D.current = false;
	#ID = Network.getIdentifierPlayer()
	print(playerPosition)
	

func _ready():
	Logger.info("Player spawned at pos x=%s y=%s" % [playerVelocity.x, playerVelocity.y])
	pass # Replace with function body.
