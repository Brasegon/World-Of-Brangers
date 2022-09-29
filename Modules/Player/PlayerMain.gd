extends "res://Modules/Player/AbstractPlayer.gd"


onready var animationPlayer = $AnimationPlayer
var positionAnim = 0

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
	playerVelocity.x = (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")) * SPEED
	playerVelocity.y = (Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")) * SPEED
	animation_player()
	playerVelocity = move_and_slide(playerVelocity * delta)
	setPlayerPos(global_transform.origin)

# Called when the node enters the scene tree for the first time.
func _ready(): 
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
