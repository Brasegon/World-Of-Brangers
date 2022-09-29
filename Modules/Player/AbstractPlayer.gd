extends KinematicBody2D

# Player Abstract Class (Main and Other Player)
const SPEED = 10000
var playerVelocity = Vector2.ZERO
var playerPosition = Vector2.ZERO

func getPlayerPos():
	return playerVelocity;
	
func setPlayerPos(playerPosSet):
	global_transform.origin = playerPosSet;
	playerPosition = global_transform.origin;

func init():
	var test = Vector2.ZERO
	test.x = 200;
	test.y = 1;
	setPlayerPos(test);
	print(playerPosition)

func _ready():
	Logger.info("Player spawned at pos x=%s y=%s" % [playerVelocity.x, playerVelocity.y])
	pass # Replace with function body.
