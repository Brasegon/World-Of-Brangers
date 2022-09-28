extends KinematicBody2D

# Player Abstract Class (Main and Other Player)
const SPEED = 10000
var playerPosition = position


func getPlayerPos():
	return playerPosition;
	
func setPlayerPos(playerPosSet):
	playerPosition = playerPosSet;

func _ready():
	Logger.info("Player spawned at pos x=%s y=%s" % [playerPosition.x, playerPosition.y])
	pass # Replace with function body.
