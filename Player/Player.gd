extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const ACCELERATION = 500
const MAX_SPEED = 500
const FRICTION = 5000

var velocity = Vector2.ZERO
func _physics_process(delta):
	var playerPosition = Vector2.ZERO
	playerPosition.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	playerPosition.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	playerPosition = playerPosition.normalized()
	
	
	if playerPosition != Vector2.ZERO:
		velocity = velocity.move_toward(playerPosition * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
	velocity = move_and_slide(velocity)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
