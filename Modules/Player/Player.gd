extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const SPEED = 10000

var playerPosition = Vector2.ZERO
onready var animationPlayer = $AnimationPlayer
var positionAnim = 0

func animation_player_x():
	if (playerPosition.x > 0):
		animationPlayer.play("Walk_right")
		positionAnim = 1
	elif (playerPosition.x < 0):
		animationPlayer.play("Walk_left")
		positionAnim = 0
	elif (playerPosition.x == 0 and playerPosition.y != 0 and positionAnim):
		animationPlayer.play("Walk_right")
	elif (playerPosition.x == 0 and playerPosition.y != 0 and !positionAnim):
		animationPlayer.play("Walk_left")
		

func animation_player():
	if (playerPosition.y > 0):
		animation_player_x()
	elif (playerPosition.y < 0):
		animation_player_x()
	elif (playerPosition.y == 0):
		animation_player_x()


func _physics_process(delta):
	playerPosition.x = (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")) * SPEED
	playerPosition.y = (Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")) * SPEED
	animation_player()
	
	playerPosition = move_and_slide(playerPosition * delta)

# Called when the node enters the scene tree for the first time.
func _ready(): 
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
